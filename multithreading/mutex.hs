{-# LANGUAGE BangPatterns #-} -- important to use the ! synthax to force eager evalution. Otherwise the thread can return thunk (promesses and actually do nothing)

import Control.Concurrent
import Control.Monad
main = do
    let numWorkers = 3
    mutex <- newMVar () 
    forM_ [1..numWorkers] (forkIO.process mutex)
    threadDelay 5000000 -- no direct join  

process mutex i = do
    takeMVar mutex -- wait until the mutex contains (). take the lock 
    putStrLn $ "Worker " ++ show i ++ " stats to work"
    threadDelay 1000000 -- 1,000,000 microseconds = 1 seconds
    let !myRes = 1
    putStrLn $ "Worker " ++ show i ++ " finished"
    putMVar mutex () -- delock the mutex by putting ()