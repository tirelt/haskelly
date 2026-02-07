{-# LANGUAGE DeriveAnyClass #-}

data SomeException = forall e. (Exception e) => SomeException e

class (Typeable e, Show e) => Exception e where
  toException :: e -> SomeException
  fromException :: SomeException -> Maybe e
  displayException :: e -> String

data MyArithException = DivByZero | OtherArithException
  deriving (Show, Exception)

divPure :: Int -> Int -> Int
divPure _ 0 = throw DivByZero
divPure a b = a `div` b

{-
throw
throwIO
ioError
throwTo

CLEANUP AFTER OPERATIONS
bracket :: IO a -> (a -> IO b) -> (a -> IO c) -> IO c
bracket acquire release use = ...

RECOVERY WITH TRY*
try :: Exception e => IO a -> IO (Either e a)

CATCH* AND HANDLE
 testComputation a b c `catch` handler
-}