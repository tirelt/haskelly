import Data.Function ((&))

data Tree a = Empty | Node a (Tree a) (Tree a) deriving (Show)  



freeTree :: Tree Char  
freeTree = 
    Node 'P'  
        (Node 'O'  
            (Node 'L'  
                (Node 'N' Empty Empty)  
                (Node 'T' Empty Empty)  
            )  
            (Node 'Y'  
                (Node 'S' Empty Empty)  
                (Node 'A' Empty Empty)  
            )  
        )  
        (Node 'L'  
            (Node 'W'  
                (Node 'C' Empty Empty)  
                (Node 'R' Empty Empty)  
            )  
            (Node 'A'  
                (Node 'A' Empty Empty)  
                (Node 'C' Empty Empty)  
            )  
        ) 


-- not enough data 
data Crumb a = LeftCrumb a (Tree a) | RightCrumb a (Tree a) deriving (Show) 
type Crumbs a = [Crumb a]  
type Zipper a = (Tree a, Crumbs a)  


goLeft :: Zipper a -> Maybe (Zipper a)  
goLeft (Node x l r, bs) = Just (l, LeftCrumb x r:bs)  
goLeft (Empty, _) = Nothing  
  
goRight :: Zipper a -> Maybe (Zipper a)  
goRight (Node x l r, bs) = Just (r, RightCrumb x l:bs)  
goRight (Empty, _) = Nothing 


goUp :: Zipper a -> Zipper a  
goUp (t, LeftCrumb x r:bs) = (Node x t r, bs)  
goUp (t, RightCrumb x l:bs) = (Node x l t, bs) 

coolTree = Node 1 Empty (Node 3 Empty Empty)  
testJust = return (freeTree,[]) >>= goRight 
testNothing = return (coolTree,[]) >>= goRight >>= goRight >>= goRight