# FFI

## Shared lib
```zsh
gcc -dynamiclib -o libmyffi.dylib foreign_function.c -install_name @rpath/libmyffi.dylib
ghc Main.hs -L. -lmyffi -optl-Wl,-rpath,. -o main
```

## Static 

```zsh
ghc Main.hs foreign_function.c -o main
```
