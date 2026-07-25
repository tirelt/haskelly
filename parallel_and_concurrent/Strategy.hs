module Main where

import Control.Parallel.Strategies

type Strategy a = a -> Eval a

parPair :: Strategy (a,b)
parPair (a,b) = do
	 a' <- rpar a 
	 b' <- rpar b
	 return (a',b')

using :: a -> Strategy a -> a
x `using` s = runEval (s x)

-- More generic 

evalPair :: Strategy a -> Strategy b -> Strategy (a,b)
evalPair sa sb (a,b) = do
	 a' <- sa a
	 b' <- sb b
	 return (a',b')

parPair :: Strategy (a,b)
parPair = evalPair rpar rpar

rdeepseq :: NFData a => Strategy a
rdeepseq x = rseq (force x)

rparWith :: Strategy a -> Strategy a -- rpaWith s = wrap the Stregy s in an rpar
rparWith s = s >== \x -> rpar x


