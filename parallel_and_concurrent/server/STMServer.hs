module Main where

import Control.Concurrent
import Control.Monad (forever)
import Network.Socket
import System.IO 
import Text.Printf 
import Control.Concurrent.STM 
import Control.Concurrent.Async (race)

talk :: Handle -> TVar Integer -> IO ()
talk h factor = do
  hSetBuffering h LineBuffering
  c <- atomically newTChan
  race (server h factor c) (receive h c)
  return ()

receive :: Handle -> TChan String -> IO ()
receive h c = forever $ do
  line <- hGetLine h
  atomically $ writeTChan c line

server :: Handle -> TVar Integer -> TChan String -> IO ()
server h factor c = do
  f <- atomically $ readTVar factor     -- <1>
  hPrintf h "Current factor: %d\n" f    -- <2>
  loop f                                -- <3>
 where
  loop f = do
    action <- atomically $ do           -- <4>
      f' <- readTVar factor             -- <5>
      if (f /= f')                      -- <6>
         then return (newfactor f')     -- <7>
         else do
           l <- readTChan c             -- <8>
           return (command f l)         -- <9>
    action

  newfactor f = do                      -- <10>
    hPrintf h "new factor: %d\n" f
    loop f

  command f s                           -- <11>
   = case s of
      "end" ->
        hPutStrLn h ("Thank you for using the " ++
                     "Haskell doubling service.")         -- <12>
      '*':s -> do
        atomically $ writeTVar factor (read s :: Integer) -- <13>
        loop f
      line  -> do
        hPutStrLn h (show (f * (read line :: Integer)))
        loop f
-- >>

main :: IO ()
main = withSocketsDo $ do
    -- Create and configure the listening socket
    sock <- socket AF_INET Stream defaultProtocol
    setSocketOption sock ReuseAddr 1
    bind sock (SockAddrInet (fromIntegral port) 0)
    listen sock 5
    printf "Listening on port %d\n" port
    factor <- atomically $ newTVar 2 
    forever $ do
        -- 1. accept returns a raw Socket and a SockAddr (not a Handle and a String)
        (connSock, clientAddr) <- accept sock
        printf "Accepted connection from %s\n" (show clientAddr)
        
        -- 2. Convert the raw socket into a standard Haskell I/O Handle
        handle <- socketToHandle connSock ReadWriteMode
        
        -- 3. Fork the thread and safely close the handle when finished
        forkFinally (talk handle factor) (\_ -> hClose handle)

port :: Int
port = 44444
