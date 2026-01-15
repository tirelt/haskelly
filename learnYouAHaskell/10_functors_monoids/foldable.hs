import qualified Data.Foldable as F  
import Data.Monoid (Any(..))

foldExample = F.foldl (+) 2 (Just 9)  -- 11
orExample = F.foldr (||) False (Just True)  -- true

data Tree a = Empty | Node a (Tree a) (Tree a) deriving (Show, Read, Eq)  

instance F.Foldable Tree where  
    foldMap f Empty = mempty  
    foldMap f (Node x l r) = F.foldMap f l `mappend` -- f must return a Monoid (exemple list or Any)  
                             f x           `mappend`  
                             F.foldMap f r  

testTree = Node 5  
            (Node 3  
                (Node 1 Empty Empty)  
                (Node 6 Empty Empty)  
            )  
            (Node 9  
                (Node 8 Empty Empty)  
                (Node 10 Empty Empty)  
            )  

sumNode = F.foldl (+) 0 testTree
productNode = F.foldl (*) 1 testTree 

anyMonoidFold = getAny $ F.foldMap (\x -> Any $ x > 15) testTree  