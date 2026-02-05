import Data.IORef
import Text.Read (readMaybe)

{-
newIORef :: a -> IO (IORef a)

readIORef :: IORef a -> IO a
writeIORef :: IORef a -> a -> IO ()
modifyIORef :: IORef a -> (a -> a) -> IO ()
modifyIORef' :: IORef a -> (a -> a) -> IO ()
-}

sumNumbers :: IO Int
sumNumbers = do
  s <- newIORef 0
  go s
  where
    go acc = readNumber >>= processNumber acc

    readNumber = do
      putStr "Put integer number (not a number to finish): "
      readMaybe <$> getLine

    processNumber acc Nothing = readIORef acc
    processNumber acc (Just n) = modifyIORef' acc (+ n) >> go acc

main :: IO ()
main = do
  s <- sumNumbers
  putStr "Your sum is: "
  print s
