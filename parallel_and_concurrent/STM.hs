module Main where

import Control.Concurrent.STM
import Control.Concurrent
import Control.Exception

import Data.Map as M
import Data.Set as S
main :: IO ()
main = pure ()

{-
data STM a -- abstract
instance Monad STM -- among other things

atomically :: STM a -> IO a

data TVar a -- abstract
newTVar :: a -> STM (TVar a)
readTVar :: TVar a -> STM a
writeTVar :: TVar a -> a -> STM ()

retry :: STM a -- to retry the current transaction
orElse :: STM a -> STM a -> STM -- 

throwSTM :: Exception e => e -> STM a
catchSTM :: Exception e => STM a -> (e -> STM a) -> STM a

-}

data Desktop -- abstract
data Window -- abstract

type Display = Map Desktop (TVar (S.Set Window))

moveWindowSTM :: Display -> Window -> Desktop -> Desktop -> STM ()
moveWindowSTM disp win a b = do
  wa <- readTVar ma
  wb <- readTVar mb
  writeTVar ma (S.delete win wa)
  writeTVar mb (S.insert win wb)
  where
    ma = disp ! a
    mb = disp ! b

moveWindow :: Display -> Window -> Desktop -> Desktop -> IO ()
moveWindow disp win a b = atomically $ moveWindowSTM disp win a b

swapWindows :: Display
  -> Window -> Desktop
  -> Window -> Desktop
  -> IO ()
swapWindows disp w a v b = atomically $ do
  moveWindowSTM disp w a b
  moveWindowSTM disp v b a

-- Implemenation of MVar with TMVar

newtype TMVar' a = TMVar' (TVar (Maybe a))

newEmptyTMVar :: STM (TMVar' a)
newEmptyTMVar = do
  t <- newTVar Nothing
  return (TMVar' t)

takeTMVar' :: TMVar' a -> STM a
takeTMVar' (TMVar' t) = do
  m <- readTVar t 
  case m of
    Nothing -> retry 
    Just a -> do
      writeTVar t Nothing
      return a

putTMVar' :: TMVar' a -> a -> STM ()
putTMVar' (TMVar' t) a = do
  m <- readTVar t
  case m of
    Nothing -> do
      writeTVar t (Just a)

      return ()
    Just _ -> retry

--takeBoth :: TMVar' a -> TMVar' b -> IO (a,b)

takeBoth ta tb = atomically $ do
  a <- takeTMVar' ta
  b <- takeTMVar' tb
  return (a,b)

takeEitherTMVar :: TMVar a -> TMVar b -> STM (Either a b)
takeEitherTMVar ma mb =
  fmap Left (takeTMVar ma)
  `orElse`
  fmap Right (takeTMVar mb)

data Async' a = Async' ThreadId (TMVar' (Either SomeException a))

async :: IO a -> IO (Async' a)
async action = do
  var <- newEmptyTMVarIO
  t <- forkFinally action (atomically . putTMVar' var)
  return (Async' t var)

waitCatchSTM :: Async a -> STM (Either SomeException a)
waitCatchSTM (Async _ var) = readTMVar var

waitSTM :: Async a -> STM a
waitSTM a = do
  r <- waitCatchSTM a
  case r of
    Left e -> throwSTM e
    Right a -> return a

waitEither :: Async a -> Async b -> IO (Either a b)
waitEither a b = atomically $
  fmap Left (waitSTM a)
  `orElse`
  fmap Right (waitSTM b)

--- Channel with STM
{-
data TChan a
newTChan :: STM (TChan a)
writeTChan :: TChan a -> a -> STM ()
readTChan :: TChan a -> STM a
-}
data TChan a = TChan (TVar (TVarList a)) (TVar (TVarList a))
type TVarList a = TVar (TList a)
data TList a = TNil | TCons a (TVarList a)

newTChan :: STM (TChan a)
newTChan = do
  hole <- newTVar TNil
  read <- newTVar hole
  write <- newTVar hole
  return (TChan read write)

readTChan :: TChan a -> STM a
readTChan (TChan readVar _) = do
  listHead <- readTVar readVar
  head <- readTVar listHead
  case head of
    TNil -> retry
    TCons val tail -> do
      writeTVar readVar tail
      return val

writeTChan :: TChan a -> a -> STM ()
writeTChan (TChan _ writeVar) a = do
  newListEnd <- newTVar TNil
  listEnd <- readTVar writeVar
  writeTVar writeVar newListEnd
  writeTVar listEnd (TCons a newListEnd)

unGetTChan :: TChan a -> a -> STM ()
unGetTChan (TChan readVar _) a = do
  listHead <- readTVar readVar
  newHead <- newTVar (TCons a listHead)
  writeTVar readVar newHead

isEmptyTChan :: TChan a -> STM Bool
isEmptyTChan (TChan read _write) = do
  listhead <- readTVar read
  head <- readTVar listhead
  case head of
    TNil -> return True
    TCons -> return False

readEitherTChan :: TChan a -> TChan b -> STM (Either a b)
readEitherTChan a b =
  fmap Left (readTChan a)
  `orElse`
  fmap Right (readTChan b)
