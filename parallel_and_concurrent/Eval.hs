module Main where

import Control.Parallel.Strategies

{-
newtype Eval a = Done a

runEval :: Eval a -> a
runEval (Done x) = x

instance Functor Eval where
  fmap f (Done x) = Done (f x)

instance Applicative Eval where
  pure x = Done x
  Done f <*> Done x = Done (f x)

instance Monad Eval where
  return x = Done x
  Done x >>= k = k x   -- Pattern matching on 'Done x' forces sequencing


-- | Spark the argument in parallel to be evaluated to WHNF
rpar :: a -> Eval a
rpar x = x `par` Done x

-- | Evaluate the argument sequentially to WHNF right now
rseq :: a -> Eval a
rseq x = x `pseq` Done x 

pseq forbids the compiler to reorder 
-}

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



