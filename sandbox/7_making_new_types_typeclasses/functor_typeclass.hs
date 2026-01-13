import Tree
-- typeclass that take a constructor as parameter. 

class Functor' f where  
    fmap' :: (a -> b) -> f a -> f b  

instance Functor' [] where  
    fmap' = map  

instance Functor' Maybe where  
    fmap' f (Just x) = Just (f x)  
    fmap' f Nothing = Nothing 

instance Functor' Tree where  
    fmap' f EmptyTree = EmptyTree  
    fmap' f (Node x leftsub rightsub) = Node (f x) (fmap f leftsub) (fmap f rightsub) 

maybeInstance = Just "Something serious."
maybeExample = fmap' (++ " HEY GUYS IM INSIDE THE JUST") maybeInstance