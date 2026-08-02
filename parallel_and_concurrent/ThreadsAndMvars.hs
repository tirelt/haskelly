module Main where 

import Control.Concurrent
import Control.Monad
import System.IO

{-
forkIO :: IO () -> IO ThreadId - new thread that runs concurrently with the other threads in the system
threadDelay :: Int -> IO ()

-- Communication
newEmptyMVar :: IO (MVar a)
newMVar :: a -> IO (MVar a)
takeMVar :: MVar a -> IO a
putMVar :: MVar a -> a -> IO ()

-- Unbounded Channels 
newChan :: IO (Chan a)
readChan :: Chan a -> IO a
writeChan :: Chan a -> a -> IO ()

-- the current contents of the channel are represent as a Stream
data Chan a = Chan (MVar (Stream a)) (MVar (Stream a)) -- need to keep track of the strat (where we take values), the read pointer and the end (where we write new values), the write pointer.
type Stream a = MVar (Item a)
data Item a = Item a (Stream a)


newChan :: IO (Chan a)
newChan = do
hole <- newEmptyMVar
readVar <- newMVar hole
writeVar <- newMVar hole
return (Chan readVar writeVar)

writeChan :: Chan a -> a -> IO ()
writeChan (Chan _ writeVar) val = do
newHole <- newEmptyMVar
oldHole <- takeMVar writeVar
putMVar oldHole (Item val newHole)
putMVar writeVar newHole

readChan :: Chan a -> IO a
readChan (Chan readVar _) = do
stream <- takeMVar readVar --
Item val tail <- takeMVar stream --
putMVar readVar tail --
return val

modifyMVar :: MVar a -> (a -> IO (a, b)) -> IO b
modifyMVar_ :: MVar a -> (a -> IO a) -> IO ()
-}

main :: IO ()
main = pure ()


