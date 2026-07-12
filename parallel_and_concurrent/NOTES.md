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

We need the flag `-threaded` to allow multithreading. The we can use `+RTS -N2` to tell the program to sue multiple cores.

```zsh
ghc -O2 test.hs -threaded
./rpar 1 +RTS -N2
```
better to use directly cabal

```zsh
cabal build rpar.hs
 cabal run rpar -- 3 +RTS -N2
```

## WHNF

```haskell
let x = 1 + 2 :: Int
:sprint x # to print the value without evaluating
```
Unevaluated computation = `thunk`

### Weak head normal form 

Evaluate as far as the first constructor
```haskell
seq x () # to get the WHNF of x
```
## Eval Monad

