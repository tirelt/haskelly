{-
instance Monad [] where  
    return x = [x]  
    xs >>= f = concat (map f xs)  
    fail _ = []  
-}

applyAndFlatten = [3,4,5] >>= \x -> [x,-x] 

so = [1,2] >>= \n -> ['a','b'] >>= \ch -> return (n,ch)  --  [(1,'a'),(1,'b'),(2,'a'),(2,'b')]  

-- equivalent to 
listOfTuples = do  
    n <- [1,2]  
    ch <- ['a','b']  
    return (n,ch)  

-- equivaelnt to 
comprehension = [ (n,ch) | n <- [1,2], ch <- ['a','b'] ] 
-- list comprehension is just syntactic sugar for using lists as monads