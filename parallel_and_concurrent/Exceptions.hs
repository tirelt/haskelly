module Main where

import  Control.Exception

main :: IO ()
main = pure ()

{-
throw :: Exception e => e -> a

newtype ErrorCall = ErrorCall String
deriving (Typeable)
instance Show ErrorCall where { ... }
instance Exception ErrorCall

error :: String -> a
error s = throw (ErrorCall s)

catch :: Exception e => IO a -> (e -> IO a) -> IO a
handle :: Exception e => (e -> IO a) -> IO a -> IO a -- same just inverted arguments

try :: Exception e => IO a -> IO (Either e a)

onException io what = io `catch` \e -> do 
  _ <- what
  throwIO (e :: SomeException)

throwIO :: Exception e => e -> IO a -- the version of throw to use in the IO monad (guarantees stict ordering with repect to other IO operations)

bracket :: IO a -> (a -> IO b) -> (a -> IO c) -> IO c
bracket before after during = do
a <- before
c <- during a
`onException` after a
after a
return c

finally :: IO a -> IO b -> IO a
finally io after = do
io `onException` after
after
-}
data MyException = MyException deriving (Show)
instance Exception MyException

catchEx = throw MyException `catch` \e -> print (e :: MyException)

tryEx = try (readFile "nonexistent") :: IO (Either IOException String)
