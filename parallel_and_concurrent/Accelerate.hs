module Main where 

import Data.Array.Accelerate as A
import Data.Array.Accelerate.Interpreter as I

main :: IO ()
main = pure ()

{-
data Array sh e
data Z = Z
data tail :. head = tail :. head

type DIM0 = Z
type DIM1 = DIM0 :. Int
type DIM2 = DIM1 :. Int

type Scalar e = Array DIM0 e
type Vector e = Array DIM1 e

fromList :: (Shape sh, Elt e) => sh -> [e] -> Array sh e

-- they cannnot be nested but can ba array of tuples

run :: Arrays a => Acc a -> a
-- to build an Accelerate computaton

A.map :: (Shape ix, Elt a, Elt b)
=> (Exp a -> Exp b)
-> Acc (Array ix a)
-> Acc (Array ix b)

use :: Arrays arrays => arrays -> Acc arrays
-- to trun our Array into an Acc (Array), this is when we potentially copy the array form the computer main memory into the GPU's memory 


-- Acc: computation delivering an array
-- Exp: computation delivering a single value. Expression using integer constand and overloaded Num operations work just fine (because Accelerate provides an instance for Num (Exp a)

unit :: Elt e => Exp e -> Acc (Scalar e) -- to convert an expression to Acc Array
the :: Elt e => Acc (Scalar e) -> Exp e -- the dual

(!) :: (Shape ix, Elt e) => Acc (Array ix e) -> Exp ix -> Exp e

index1 :: Exp Int -> Exp (Z :. Int)

Creating arrays inside Accelerate (to avoid copies)

fill :: (Shape sh, Elt e) => Exp sh -> Exp e -> Acc (Array sh e)
enumFromN :: (Shape sh, Elt e, IsNum e) => Exp sh -> Exp e -> Acc (Array sh e)
enumFromStepN :: (Shape sh, Elt e, IsNum e) => Exp sh -> Exp e -> Exp e -> Acc (Array sh e)
generate :: (Shape ix, Elt a) => Exp ix -> (Exp ix -> Exp a) -> Acc (Array ix a)

index2 :: Exp Int -> Exp Int -> Exp DIM2
index2 i j = lift (Z :. i :. j)
lift :: Z :. Exp Int :. Exp Int -> Exp (Z :. Int :. Int)

zipWith :: (Shape ix, Elt a, Elt b, Elt c) => (Exp a -> Exp b -> Exp c) -> Acc (Array ix a) -> Acc (Array ix b) -> Acc (Array ix c)

constant :: Elt t => t -> Exp t
-}

newVec :: Vector Int 
newVec = fromList (Z:.10) [1..10]

new2d :: Array DIM2 Int
new2d = fromList (Z:.3:.5) [1..] 

el :: Int
el = indexArray new2d (Z:.2:.1) 
-- to index an array OUTSIDE Accelerate computation context


res = run $ A.map (+1) (use new2d)

res2 = run $ unit (3::Exp Int)

el2 = run $ unit (use new2d ! index2 1 1)

newArrFromAcc= run $ enumFromStepN (index2 3 5) 15 (-1) :: Array DIM2 Int

newArrFromGen = run $ generate (index2 3 5) (\ix -> let Z:.y:.x = unlift ix in x + y)
-- unlift :: Exp (Z :. Int :. Int) -> Z :. Exp Int :. Exp Int

a = enumFromN (index2 2 3) 1 :: Acc (Array DIM2 Int)
b = enumFromStepN (index2 2 3) 6 (-1) :: Acc (Array DIM2 Int)
c = run $ A.zipWith (+) a b
