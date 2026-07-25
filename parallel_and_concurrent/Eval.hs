module Main where

import Control.Parallel.Strategies

data Eval a
instance Monad Eval
runEval :: Eval a -> a
rpar :: a -> Eval a
rseq :: a -> Eval a

f :: Num a => a -> a
f x = 2

x :: Int
x = 1

y :: Int
y = 2

g = runEval $ do
	 a <- rpar (f x)
	 b <- rpar (f y)
	 -- returns straight away the evalution continue in parallel 
	 return (a, b)

l = runEval $ do
	 a <- rpar (f x)
	 b <- rseq (f y)
	 -- returns after b evaluates
	 return (a, b)
main :: IO ()
main = do 
	 let (a,b) = g
	 putStrLn $ "a = " ++ show a ++ ", b = " ++ show b



