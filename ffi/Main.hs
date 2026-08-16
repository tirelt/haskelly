{-# LANGUAGE ForeignFunctionInterface #-}

module Main where

import Foreign.C.Types (CInt(..))

-- Bind to the C function inside the shared library
foreign import ccall unsafe "add" c_sum :: CInt -> CInt -> CInt

main :: IO ()
main = putStrLn $ "The sum of " ++ show a ++ " and " ++ show b ++ " is " ++ show (c_sum a b)
  where a = 3
        b = 6
