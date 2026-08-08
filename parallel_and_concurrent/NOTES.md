# Parallel and Concurrent Programming in Haskell

## Install

### Examples

```zsh
cabal unpack parconc-examples
cabal install --only-dependencies --allow-newer # to resolve for more recent dependencies
```
### Threadscope

```zsh
brew install threadscope
```
### Making the project work 

A LLM fixed for us the issue of the outdated dependencies

In `parconc-examples`:
```zsh
cabal build
```
Tested with cabal 9.10.

Test with `--allow-newer` to find the version we can use and update .cabal file.

## GHC 

We need the flag `-threaded` to allow multithreading. Then we can use `+RTS -N2` to tell the program to sue multiple cores.

```zsh
ghc -O2 test.hs -threaded
./rpar 1 +RTS -N2
```
better to use directly cabal

```zsh
cabal build rpar.hs
 cabal run rpar -- 3 +RTS -N2 -l
```

### Flags

#### Compile 

```zsh
-rstopts  # to allow Runtime System Options which allow the pogram to accept arguments (enclosed between +RTS and -RTS)
-with-rtsopts="-N" # to specfity RTS options directly
-fflvm # to enable GHC LLVM backend
-O2 # O2 optim
```
#### Run
```zsh
+RTS -N2 # to use 2 cores
+RTS -s # for GHC runtime syustem to emit the statistics.
+RTS -l # to generate the eventlog file to open with threadscope
```
Then open the `.eventlog` with threadscope.

## Lazy evaluation

```haskell
let x = 1 + 2 :: Int
:sprint x -- to print the value without evaluating
```
Unevaluated computation = `thunk`

### Weak head normal form 

Evaluate as far as the first constructor and returns the second argument.
```haskell
seq x () -- to get the WHNF of x
```
### Normal form

We need to use `force :: NFData a => a -> a` to evaluates the entire structure of its argument.

It is in `Control.DeepSeq`.

Normal Form data:  norma form is a value with no unevaluated subexpressions.


class NFData ahs only one method `rnf` for reduce to normal form

We can use `deepseq` to deep evaluate an expression and turn it into a NF.

```haskell
force :: NFData a => a -> a
force x = x `deepseq` x
```

## What to use

- If we deal we Lazy data structure then wrinting a `Strategy` to evaluate it in parallel will pronbably work well
- `runPar` is epensive whereas `runEval` is free. Do not nest `runPar`.
- `Eval` tends to perfom better at finer granularities due to the direct runtime system support for sparks. At larger granularities `Par` and `Eval` perform approximately the same.
- `Par` monad is 9implemented entirely in a Haskell lib so can be hacked. It doesn't support speculative paraallelism. Parellelism in the `Par` monad is always executed.
- `Eval` monad have more diagnostics in ThreadScope.

## Accelerate

### Type classes
#### Elt

The class of types that may be array elements. Includes all the usual numeric types,
as well as indices and tuples. In types of the form Exp e, the e is often required to
be an instance of Elt. Note in particular that arrays are not an instance of Elt; this
is the mechanism by which Accelerate enforces that arrays cannot be nested.

#### Arrays
This type class includes arrays and tuples of arrays. In Acc a, the a must always be
an instance of the type class Arrays.

#### Shape
The class of shapes and indices. This class includes only Z and :. and is used to
ensure that values used as shapes and indices are constructed from these two types.

### Running on GPU

flag to see what the GPU is doing
```zsh
cabal install accelerate-cuda -fdebug
```
Then we need 
```haskell
import Data.Array.Accelerate.CUDA -- instead of import Data.Array.Accelerate.Interpreter
```
`-dverbose`: prints some information about the type and capbilities of the GPU
`-ddump-cc`L prints information about CUDA Kernel

## Concurrency

The progrAm terminates when main returns, even if there are other threads still runnin. Ths other threas stop running and cease to exist after main returns.

We use `MVar` to communicate between threads.

We use `mask` so inside asynchronous exception s are no longer asynchronous but they can still riased by certain operations. the `restore` function inside the mask restores the masking state outside the mask. 

Interruptible operations (like takeMVar) may receive asynchronous exceptions even inside `mask`.

All operations that may block indefinitly are designated as interruptible.

An intereruptible operation may receive an asynchronous exception only if it actually blocks.

We can use `uninterruptibleMask` to prevent interruptible operations to be interrupted but this is very dangerous.

We can use `getMaskingState` to debug and  determine the state of a thread (`Unmasked`, `MaskedInterruptible`, `MaskedUninterruptible`)

`bracket` is actually deined with `mask` to make it sage in the presence of asynchronous exceptions.

We can use `modifyMVar_` instead of `takeMVar` / `putMVar` to make our code safe in  the presence of asynchronous axceptions.

Asynchronous exceptions are masked inside excepption handlers by defualt.

`forkIO` inherits the masking state of the parent thread.
## Exceptions

Can only be caught in the IO monad.

`SomeException` to catch everything.The exception types form a hierarchuy and at the top there is `SomeException`.

Can be handle with `catch` or `try`.

## Software Transactional Memory

`TVar`: transactional variable -> mutable variable that can be read or written only within the speicial STM monad using `readTVar` and `writeTVar`.

The STM implementation relies on being able to roll back the effects of a transaction in the event of a conflict with another transaction.
A transaction can be rolled back only if we can track exactly what effects it has (which is not the case for an arbitrary IO action).
For this reason, the STM monad permits only side effects on TVars.
