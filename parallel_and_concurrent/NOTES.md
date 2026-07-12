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
