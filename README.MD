# Haskell

Trying out Haskell.

![Ackchyually](ackchyally.png)

# Install 

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

# Doc 

- [Lean you a Haskell](https://learnyouahaskell.github.io/introduction.html#so-whats-haskell)

# Intercative 
```bash
ghci # open interactive window
:l [module_name] # import function from files
:q # quit
:r # reload module
```