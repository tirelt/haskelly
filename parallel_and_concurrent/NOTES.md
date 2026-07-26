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

- If we deal we Lazy data structure then wrinting a `Strategy` to evaluate it in parallel will pronbablr work well
- `runPar` is epensive whereas `runEval` is free. Do not nest `runPar`.
- `Eval` tends to perfom better at finer granularities due to the direct runtime system support for sparks. At larger granularities `Par` and `Eval` perform approximately the same.
- `Par` monad is 9implemented entirely in a Haskell lib so can be hacked. It doesn't support speculative paraallelism. Parellelism in the `Par` monad is always executed.
- `Eval` monad have more diagnostics in ThreadScope.


