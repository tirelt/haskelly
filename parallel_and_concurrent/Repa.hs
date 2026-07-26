module Main where

import Data.Array.Repa as Repa

main :: IO ()
main = pure () 

{-
data Array r sh e -- r: representation type, sh: shape, e: type of the elements

data Z = Z 
data tail :. head = tail :. head

type DIM0 = Z
type DIM1 = DIM0 :. Int
type DIM2 = DIM1 :. Int

fromListUnboxed :: (Shape sh, Unbox a) => sh -> [a] -> Array U sh a
-- to init an array

(!) :: (Shape sh, Source r e) => Array r sh e -> sh -> e
-- to get an elemement

toIndex :: Shape sh => sh -> sh -> Int
-- convert an index to an Int offset

we can reshape witthout copying the array

rank :: Shape sh => sh -> Int -- number of dimensions
size :: Shape sh => sh -> Int -- number of elements
extent :: (Shape sh, Source r e) => Array r sh e -> sh -- get the shape

Repa.map :: (Shape sh, Source r a) => (a -> b) -> Array r sh a -> Array D sh b
-- D is for delayed, not computed yet
-- so  a sequence of operations can be performed without ever building the intermediate arrays: FUSION
-- if we compile with -O it will potentially do a single efficient loop over the array

computeS :: (Load r1 sh e, Target r2 e) => Array r1 sh e -> Array r2 sh e
-- to compute a delayed array

fromFunction :: sh -> (sh -> a) -> Array D sh a
-- to create a delayed array


computeP :: (Monad m, Source r2 e, Target r2 e, Load r1 sh e)
=> Array r1 sh e
-> m (Array r2 sh e)
-- to compute in Parallel, in need to run in a Monad jsut to ensure that the computep operation sare perfomed in  sequence so we can use the Identity monad


foldS :: (Shape sh, Source r a, Elt a, Unbox a)
=> (a -> a -> a) -> a --
-> Array r (sh :. Int) a -> Array U sh a

foldP :: (Shape sh, Source r a, Elt a, Unbox a, Monad m)
=> (a -> a -> a)
-> a
-> Array r (sh :. Int) a
-> m (Array U sh a)

-}

newUnboxed1 :: Array U DIM1 Int 
newUnboxed1 = fromListUnboxed (Z :. 10) [1..10]

newUnboxed2:: Array U DIM2 Int
newUnboxed2 = fromListUnboxed (Z :. 3 :. 5) [1..15] 

el :: Int
el = newUnboxed2 ! (Z:.2:.1)

resMapD :: Array D DIM2 Int
resMapD = Repa.map (+1) newUnboxed2

resMapC :: Array U DIM2 Int
resMapC = computeS resMapD

newDArray :: Array D DIM1 Int
newDArray = fromFunction (Z :. 10) (\(Z:.i) -> i :: Int)
-- represents the vecot of integers 0 to 9 

elD :: Int
elD = newDArray ! (Z:.3)

-- mymap :: (a -> b) -> Array r sh a -> Array D sh b
mymap f a = fromFunction (extent a) (\ix -> f (a ! ix))

