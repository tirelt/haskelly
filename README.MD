# Haskell

"you do computations in Haskell by declaring what something is instead of declaring how you get it"

![Ackchyually](ackchyally.png)


## Install 

We use [`GHCup`](https://www.haskell.org/ghcup/) to install the compiler.

```Bash
brew install ghcup # on Mac
curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh # otherwise
```

Then run `GHCup tui` and select a compiler to insall. We use the recommended `GHC` one.

Add `.ghcup` bin to `PATH`
```bash
export PATH="$HOME/.ghcup/bin:$PATH"
```
(to avoid readding every time add to .bashrc or .bash_profile)

## Doc 

- [Lean you a Haskell](https://learnyouahaskell.github.io/introduction.html#so-whats-haskell)
- [Real World Haskell](https://book.realworldhaskell.org/)

## Intercative 
```bash
ghci # open interactive window
:l [module_name] # import function from files
:q # quit
:r # reload module
:t # get the type of an expression 
:m + [module_name] # e.g. Data.List, can give several separated by space
:info [typecclass] # :info Num will show which functions the typeclass defines and it will give you a list of the types in the typeclass. :info Maybe, it will show you all the typeclasses that Maybe is an instance of. :info can show you the type declaration of a function
:k # inspect the kind of a type. a '*' is a concrete type. '*->*' means a constructor that take a concrete type and returns a conrete type (e.g Maybe give Maybe Int) 
:i # to get ingo. On a TypeClass to see the implementions. On a type to see its typeclasses
:doc # to get the doc of a Typeclass
:set -XOverloadedStrings # to enable a language feature
:set -XNoOverloadedStrings # to discable
```

## Types

- `Int`: 64 bits
- `Integer`: not bounded, less efficient
- `Float`: single precision floating point
- `Double`: double precision
- `Bool`
- `Char`
- `String` which is equal to `[Char]`
- `a`: generic type

## Typeclass

Eqauivalent to trait bound in Rust

- `Eq`: define == and /=
- `Ord`: define <, >, >=, <= and `compare` (which return an Ordering type i.e. GT,LT,EQ)
- `Show`: types that can be presented as strings (e.g. show 3)
- `Read`: The read function takes a string and returns a type which is a member of Read. Can force the type e.g. read "5" :: Int 
- `Enum`: types that can be enumerated on which we can use `succ` and `pred`. Types in this class: (), Bool, Char, Ordering, Int, Integer, Float and Double
- `Bounded`:  members have an upper and a lower bound. e.g. minBound :: Int
- `Num`: numeric typeclass, able to act like numbers.
- `Integral`: like `Num` for integral numbers
- `Floating`: Float and Double 

We can use `fromIntegral` function to convert a Integral type to a Num type ( e.g. fromIntegral (length [1,2,3,4]) + 3.2)

## Pattern matching

![alt text](pattern_matching.png)

## Curried function 

The functions take one arguments. When a function take several arguments, it actually is applies and returns a function which is then applied to the rest of the params and so on so forth.

## Standard Library 

[Haskell Hierachical Libraries](https://downloads.haskell.org/ghc/latest/docs/libraries/)

Use [Hoggle](https://hoogle.haskell.org/) to search the Haskell libraries.

## Compiling 

```Bash
ghc --make [file_name]
runhaskell [file_name] # to run on the fly
```
An I/O action will be performed when we give it a name of main and then run our program

## Concepts
- functor: `fmap :: (Functor f) => (a -> b) -> f a -> f b` 
- applicative functor: 
    - `pure :: a -> f a`
    - `(<*>) :: (Applicative f) => f (a -> b) -> f a -> f b ` 
- monad:
    - `return = pure` 
    - `(>>=) :: (Monad m) => m a -> (a -> m b) -> m b`
    - `(>>) :: m a -> m b -> m b` implemented by default by `m a >> m b = \_ -> m b` 
    - `fail :: String -> m a`

## Profiling

- [GHC doc](https://downloads.haskell.org/~ghc/7.2.1/docs/html/users_guide/profiling.html)
- [Real World Haskell](https://book.realworldhaskell.org/read/profiling-and-optimization.html)


```bash
ghc -prof -auto-all -o Main Main.hs # compile, auto-all is for the cost center
./Main +RTS -p # to run
```

## Ecosystem 

- [Hackage](https://hackage.haskell.org/): all the packages
- [Stackage](https://www.stackage.org/): a set (~30% of Hackage) compatible packages

## Project manager 

### Cabal 

```Bash
cabal init [name] --non-interactive # create new project [name] 
cabal build --enable-profiling
cabal run -- +RTS -p
cabal test [name_test]
cabal clean
cabal configure # saves build config for subsquent cabal build
cabal list 
cabal update # update the package index, local representation of Hackage
cabal outdated # to check if some of the dependencies were updated according to the local package index

```
`.cabal` contains
- build-depends: list of packages required to build the corresponding
package
- other-modules: all the modules required to build this compo-
nent (except, exposed-modules and main-is)
- default-extensions: list of compiler extensions that will be automati-
cally enabled when compiling every module in this package
- default-language: Haskell2010

## Linter 
Already packackaged with HLS it seems
```Bash
cabal install hlint
```
## Auto format

We use `ormolu`, it is the first one we found and seems to work fine

In user `setting.json`
```Json
"haskell.formattingProvider": "ormolu"
```
## Multithreading 

### Doc 
- [HaskellWiki](https://wiki.haskell.org/Haskell_for_multicores#Lock-free_synchronisation)
- [Real World Haskell](https://book.realworldhaskell.org/read/concurrent-and-multicore-programming.html)
    - LTS (Long-Term Support): Produced weekly and considered the stable release
    - Nightly: The bleeding-edge release produced nightly

### Mutex
```Haskell
newMVar :: a -> IO (MVar a) 
newEmptyMVar :: IO (MVar a)
takeMVar :: MVar a -> IO a -- will block until the MVar is non-empty
putMVar :: MVar a -> a -> IO () -- will block until the current MVar is empty
isEmptyMVar :: MVar a -> IO Bool
```

### Channel
```Haskell
newChan :: IO (Chan a)
writeChan :: Chan a -> a -> IO ()
readChan :: Chan a -> IO a
```

## Debugger 

```Bash
cabal install haskell-debugger --allow-newer=base,time,containers,ghc,ghc-bignum,template-haskell --enable-executable-dynamic # install
```
Add `.local/bin` bin to `PATH`
```bash
export PATH="$HOME/.local/bin:$PATH"
```
Check `hdb` 
```Bash
hdb --version
```
Configure [lauch.json](.vscode/launch.json)

The lazy evaluation makes it tricky to follow the execuation. 
We can use the `!` syntax to force eager evaluation.

## Language extension 

- {-# LANGUAGE OverloadedStrings #-}: String literals as values of type Text
- {-# LANGUAGE LambdaCase #-}: allow lambda of the form \case { pattern1 -> expression1; pattern2 -> expression2; ... }
- {-# LANGUAGE BangPatterns #-}:  force eager evaluation
- {-# LANGUAGE RecordWildCards #-}: we can use {..} to pattern match and constructing records
- {-# LANGUAGE NoImplicitPrelude #-}: to not import stuff from Prelude which is old and usafe