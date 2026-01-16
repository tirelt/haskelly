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


-- beurk
changeToPBeurk:: Tree Char -> Tree Char  
changeToPBeurk (Node x l (Node y (Node _ m n) r)) = Node x l (Node y (Node 'P' m n) r)  

data Direction = L | R deriving (Show)  
type Directions = [Direction]  
  
changeToP :: Directions-> Tree Char -> Tree Char  
changeToP (L:ds) (Node x l r) = Node x (changeToP ds l) r  
changeToP (R:ds) (Node x l r) = Node x l (changeToP ds r)  
changeToP [] (Node _ l r) = Node 'P' l r  

elemAt :: Directions -> Tree a -> a  
elemAt (L:ds) (Node _ l _) = elemAt ds l  
elemAt (R:ds) (Node _ _ r) = elemAt ds r  
elemAt [] (Node x _ _) = x  

-- Smarter
type Breadcrumbs = [Direction]  

goLeftBC :: (Tree a, Breadcrumbs) -> (Tree a, Breadcrumbs)  
goLeftBC (Node _ l _, bs) = (l, L:bs)

goRightBC :: (Tree a, Breadcrumbs) -> (Tree a, Breadcrumbs)  
goRightBC (Node _ _ r, bs) = (r, R:bs)  

bread = (freeTree, []) & goRightBC & goLeftBC

-- not enough data 
data Crumb a = LeftCrumb a (Tree a) | RightCrumb a (Tree a) deriving (Show) 
type Crumbs a = [Crumb a]  

goLeft :: (Tree a, Crumbs a) -> (Tree a, Crumbs a)  
goLeft (Node x l r, bs) = (l, LeftCrumb x r:bs)  

goRight :: (Tree a, Crumbs a) -> (Tree a, Crumbs a)  
goRight (Node x l r, bs) = (r, RightCrumb x l:bs)  

goUp :: (Tree a, Crumbs a) -> (Tree a, Crumbs a)  
goUp (t, LeftCrumb x r:bs) = (Node x t r, bs)  
goUp (t, RightCrumb x l:bs) = (Node x l t, bs)  

type Zipper a = (Tree a, Crumbs a)  

modify :: (a -> a) -> Zipper a -> Zipper a  
modify f (Node x l r, bs) = (Node (f x) l r, bs)  
modify f (Empty, bs) = (Empty, bs)

newFocus = modify (\_ -> 'P') $ goRight $ goLeft $ (freeTree,[])
newFocus2 = modify (\_ -> 'X') $ goUp newFocus

attach :: Tree a -> Zipper a -> Zipper a  
attach t (_, bs) = (t, bs) 

farLeft = (freeTree,[]) & goLeft & goLeft & goLeft & goLeft 
newFocus3 = farLeft & attach (Node 'Z' Empty Empty) 

topMost :: Zipper a -> Zipper a  
topMost (t,[]) = (t,[])  
topMost z = topMost (goUp z)  