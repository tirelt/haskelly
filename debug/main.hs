{-# LANGUAGE BangPatterns #-} 

main = do 
    putStrLn "hello world"
    let !res = process  -- ! to force the evaluation right away
    print res
    
process = map fn [1..10]

fn x = x * x

    