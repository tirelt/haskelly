{-
instance Monad ((->) r) where  
    return x = \_ -> x  
    h >>= f = \w -> f (h w) w  
-}

f = (+) <$> (*2) <*> (+10)

--equivalent to
addStuff :: Int -> Int  
addStuff = do  
    a <- (*2)  
    b <- (+10)  
    return (a+b)  

f' = (*2) >>= \a -> (+10) >>= \b-> return (a + b)