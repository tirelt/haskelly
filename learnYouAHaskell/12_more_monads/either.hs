{-
instance (Error e) => Monad (Either e) where  
    return x = Right x  
    Right x >>= f = f x  
    Left err >>= f = Left err  
    fail msg = Left (strMsg msg)  
-}

eitherExample =  Right 3 >>= \x -> return (x + 100) :: Either String Int  