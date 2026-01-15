nested = Just 3 >>= (\x -> Just "!" >>= (\y -> Just (show x ++ y)))

foo :: Maybe String  
foo = Just 3   >>= (\x -> 
      Just "!" >>= (\y -> 
      Just (show x ++ y)))  

-- is equivalent to 
foo' :: Maybe String  
foo' = do  
    x <- Just 3  
    y <- Just "!"  
    Just (show x ++ y)

-- do expressions are just different syntax for chaining monadic values.

-- rewriting the pole thing

landLeft n (left,right)  
    | abs ((left + n) - right) < 4 = Just (left + n, right)  
    | otherwise                    = Nothing  
  
landRight n (left,right)  
    | abs (left - (right + n)) < 4 = Just (left, right + n)  
    | otherwise                    = Nothing  
routine = do  
    start <- return (0,0)  
    first <- landLeft 2 start  
    second <- landRight 2 first  
    landLeft 1 second  

routineWhoope = do  
    start <- return (0,0)  
    first <- landLeft 2 start  
    Nothing -- banana
    second <- landRight 2 first  
    landLeft 1 second 