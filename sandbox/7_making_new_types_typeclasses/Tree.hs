module Tree (
    Tree
) where  

data Tree a = EmptyTree | Node a (Tree a) (Tree a) deriving (Show, Read, Eq)  

singleton x = Node x EmptyTree EmptyTree 

treeInsert x EmptyTree = singleton x  
treeInsert x (Node a left right)  
    | x == a = Node x left right  
    | x < a  = Node a (treeInsert x left) right  
    | x > a  = Node a left (treeInsert x right)  

treeElem x EmptyTree = False  
treeElem x (Node a left right)  
    | x == a = True  
    | x < a  = treeElem x left  
    | x > a  = treeElem x right  

numsTree = foldr treeInsert EmptyTree [8,6,4,1,7,3,5]  