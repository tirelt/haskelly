module Main where

import Control.Monad.Par

main :: IO ()
main = pure ()

{-
newtype Par a
instance Applicative Par
instance Monad Par

runPar :: Par a -> a

fork :: Par () -> Par ()

data IVar a -- instance Eq
new :: Par (IVar a)
put :: NFData a => IVar a -> a -> Par ()
get :: IVar a -> Par a
-}

fib :: Integer -> Integer
fib 0 = 1
fib 1 = 1
fib n = fib (n-1) + fib (n-2)


a = runPar $ do
  i <- new
  j <- new
  fork (put i (fib 31))
  fork (put j (fib 32))
  a <- get i
  b <- get j
  return (a + b)

spawn' :: NFData a => Par a -> Par (IVar a)
spawn' p = do
  i <- new
  fork (do x <- p; put i x)
  return i

parMapM :: (NFData a, NFData b) => (a -> Par b) -> [a] -> Par [b]
parMapM f as = do
  ibs <- mapM (spawn . f) as
  mapM get ibs
