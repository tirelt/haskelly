data CMaybe a = CNothing | CJust Int a deriving (Show)  

cmaybe = CJust 0 "haha" 

instance Functor CMaybe where  
    fmap f CNothing = CNothing  
    fmap f (CJust counter x) = CJust (counter+1) (f x)  

test = fmap (++"he") (fmap (++"ha") (CJust 0 "ho")) 

-- doesn't follow functor law  because 
test2 = fmap id (CJust 0 "haha") == CJust 0 "haha"