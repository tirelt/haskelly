module Main where 

import Control.Concurrent
import  Control.Exception

main :: IO ()
main = pure ()

data Async a = Async (MVar a)

async :: IO a -> IO (Async a)
async action = do
  var <- newEmptyMVar
  forkIO (do r <- action; putMVar var r)
  return (Async var)

wait :: Async a -> IO a
wait (Async var) = readMVar var

-- Version with exceptions handling

data Async' a = Async' (MVar (Either SomeException a))

async' :: IO a -> IO (Async' a)
async' action = do
  var <- newEmptyMVar
  forkIO (do r <- try action; putMVar var r)
  return (Async' var)

waitCatch :: Async' a -> IO (Either SomeException a)
waitCatch (Async' var) = readMVar var

wait' :: Async' a -> IO a
wait' a = do
  r <- waitCatch a
  case r of
    Left e -> throwIO e
    Right a -> return a

waitEither :: Async' a -> Async' b -> IO (Either a b)
waitEither a b = do
  m <- newEmptyMVar
  forkIO $ do r <- try (fmap Left (wait' a)); putMVar m r
  forkIO $ do r <- try (fmap Right (wait' b)); putMVar m r
  wait' (Async' m)

waitAny :: [Async' a] -> IO a -- simple but frutrating to create new thread for each async operation
waitAny as = do
  m <- newEmptyMVar
  let forkwait a = forkIO $ do r <- try (wait' a); putMVar m r
  mapM_ forkwait as
  wait' (Async' m)

-- Asynchonous Exceptions: throw by the user (e.g. he disconnects)

{-
throwTo :: Exception e => ThreadId -> e -> IO () -- to throw from one thread to another
-}

data Async'' a = Async'' ThreadId (MVar (Either SomeException a))

cancel :: Async'' a -> IO ()
cancel (Async'' t var) = throwTo t ThreadKilled

async'' :: IO a -> IO (Async'' a)
async'' action = do
  m <- newEmptyMVar
  t <- forkIO (do r <- try action; putMVar m r)
  return (Async'' t m)

-- Safer
async''' :: IO a -> IO (Async'' a)
async''' action = do
  m <- newEmptyMVar
  t <- mask $ \restore -> forkIO (do r <- try (restore action); putMVar m r)
  return (Async'' t m)

forkFinally' :: IO a -> (Either SomeException a -> IO ()) -> IO ThreadId
forkFinally' action fun =
  mask $ \restore ->
  forkIO (do r <- try (restore action); fun r)

async'''' :: IO a -> IO (Async'' a)
async'''' action = do
  m <- newEmptyMVar
  t <- forkFinally' action (putMVar m)
  return (Async'' t m)
