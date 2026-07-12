import ConcurrentUtils
import Network.Socket
import Control.Monad
import Control.Concurrent (forkIO)
import System.IO
import Text.Printf
import Control.Exception

-- <<main
main = withSocketsDo $ do
  let hints = defaultHints { addrFlags = [AI_PASSIVE], addrSocketType = Stream }
  addr:_ <- getAddrInfo (Just hints) Nothing (Just (show port))
  sock <- socket (addrFamily addr) Stream defaultProtocol         -- <1>
  bind sock (addrAddress addr)
  listen sock 5
  printf "Listening on port %d\n" port
  forever $ do                                                   -- <2>
     (clientSock, clientAddr) <- accept sock                     -- <3>
     handle <- socketToHandle clientSock ReadWriteMode
     printf "Accepted connection from %s\n" (show clientAddr)
     forkFinally (talk handle) (\_ -> hClose handle)             -- <4>

port :: Int
port = 44444
-- >>

-- <<talk
talk :: Handle -> IO ()
talk h = do
  hSetBuffering h LineBuffering                                -- <1>
  loop                                                         -- <2>
 where
  loop = do
    line <- hGetLine h                                         -- <3>
    if line == "end"                                           -- <4>
       then hPutStrLn h ("Thank you for using the " ++         -- <5>
                         "Haskell doubling service.")
       else do hPutStrLn h (show (2 * (read line :: Integer))) -- <6>
               loop                                            -- <7>
-- >>
