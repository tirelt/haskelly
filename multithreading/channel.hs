{-# LANGUAGE BangPatterns #-} -- important to use the ! synthax to force eager evalution. Otherwise the thread can return thunk (promesses and actually do nothing)

import Control.Concurrent
import Control.Monad
main = do
    let numWorkers = 3
    inputChan <- newChan
    outputChan <- newChan
    forM_ [1..numWorkers] $ \i -> do 
        putStrLn $ "Start worker " ++ show i
        forkIO $ process inputChan outputChan i
        putStrLn $ "End worker " ++ show i
    putStrLn "All job sent"
    replicateM_ numWorkers (readChan outputChan >>= print) -- will have the same effect as join as readChan will block until it gets numWorkers res

process inputChan outputChan i = do
    threadDelay (i*1000000) -- 1,000,000 microseconds = 1 seconds
    let !myRes = "Res worker " ++ show i
    writeChan outputChan myRes
