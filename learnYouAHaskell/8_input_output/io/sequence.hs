main = do  
    rs <- sequence [getLine, getLine, getLine]  
    print rs  
    mapM_ print [1,2,4] -- throw away the result
    mapM print [1,2,3] -- equivalent