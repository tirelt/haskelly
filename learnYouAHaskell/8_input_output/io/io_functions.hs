main = do
    putStr "Hey, " -- no return 
    putStr "I'm " 
    putStrLn "return"
    putChar 'e'
    putChar 'h' 
    print 42 -- break and print any instance of Show
    c <- getChar  
    return ()
    return "teho"
