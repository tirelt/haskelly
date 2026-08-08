module Main where

import Control.Concurrent (forkFinally)
import Control.Monad (forever)
import Network.Socket
import System.IO 
import Text.Printf (printf)

talk :: Handle -> IO ()
talk h = do
    hSetBuffering h LineBuffering
    loop
  where
    loop = do
        line <- hGetLine h
        if line == "end"
            then hPutStrLn h "Thank you for using the Haskell doubling service."
            else do
                let num = read line :: Integer
                hPutStrLn h (show (2 * num))
                loop

main :: IO ()
main = withSocketsDo $ do
    -- Create and configure the listening socket
    sock <- socket AF_INET Stream defaultProtocol
    setSocketOption sock ReuseAddr 1
    bind sock (SockAddrInet (fromIntegral port) 0)
    listen sock 5
    printf "Listening on port %d\n" port
    
    forever $ do
        -- 1. accept returns a raw Socket and a SockAddr (not a Handle and a String)
        (connSock, clientAddr) <- accept sock
        printf "Accepted connection from %s\n" (show clientAddr)
        
        -- 2. Convert the raw socket into a standard Haskell I/O Handle
        handle <- socketToHandle connSock ReadWriteMode
        
        -- 3. Fork the thread and safely close the handle when finished
        forkFinally (talk handle) (\_ -> hClose handle)

port :: Int
port = 44444
