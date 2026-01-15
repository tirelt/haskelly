newtype ZipList a = ZipList { getZipList :: [a] }  
{-
. If you use the data keyword to wrap a type, there’s some overhead to all that wrapping and unwrapping when your program is running. 
But if you use newtype, Haskell knows that you’re just using it to wrap an existing type into a new type

you can only have one value constructor and that value constructor can only have one field
it’s easier to make them instances of certain type 
-}

newtype CharList = CharList { getCharList :: [Char] } deriving (Eq, Show) -- can use deriving 

-- to make (a,b) a functor, we define a newtype 
newtype Pair b a = Pair { getPair :: (a,b) } 
instance Functor (Pair c) where  
    fmap f (Pair (x,y)) = Pair (f x, y)  

pairEacmple = getPair $ fmap (*100) (Pair (2,3)) -- (200,3)