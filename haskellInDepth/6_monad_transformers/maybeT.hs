import Control.Monad
import Control.Monad.Trans
import Control.Monad.Trans.Maybe

greet :: IO ()
greet = do
  putStr "What is your name? " -- IO ()
  n <- getLine -- IO String
  putStrLn $ "Hello, " ++ n -- IO ()

-- using liftIO :: IO a -> MaybeT IO a
mgreet :: MaybeT IO () -- types:
mgreet = do
  liftIO $ putStr "What is your name? " -- MaybeT IO ()
  n <- liftIO getLine -- MaybeT IO String
  liftIO $ putStrLn $ "Hello, " ++ n -- MaybeT IO ()

-- runMaybeT :: MaybeT IO a -> IO (Maybe a)
askfor :: String -> IO String
askfor prompt = do
  putStr $ "What is your " ++ prompt ++ "? "
  getLine

survey :: IO (String, String)
survey = do
  n <- askfor "name"
  c <- askfor "favorite color"
  return (n, c)

-- possibility to stop in the middle

askfor1 :: String -> IO (Maybe String)
askfor1 prompt = do
  putStr $ "What is your " ++ prompt ++ " (type END to quit)? "
  r <- getLine
  if r == "END"
    then return Nothing
    else return (Just r)

survey1 :: IO (Maybe (String, String))
survey1 = do
  ma <- askfor1 "name"
  case ma of
    Nothing -> return Nothing
    Just n -> do
      mc <- askfor1 "favorite color"
      case mc of
        Nothing -> return Nothing
        Just c -> return (Just (n, c))

askfor2 :: String -> MaybeT IO String
askfor2 prompt = do
  liftIO $ putStr $ "What is your " ++ prompt ++ " (type END to quit)? "
  r <- liftIO getLine
  if r == "END"
    then MaybeT (return Nothing) -- has type: MaybeT IO String -- can also write mzero
    else MaybeT (return (Just r)) -- has type: MaybeT IO String -- can also write return r

survey2 :: IO (Maybe (String, String))
survey2 =
  runMaybeT $ do
    a <- askfor2 "name"
    b <- askfor2 "favorite color"
    return (a, b)

-- equivalently
askfor3 :: String -> MaybeT IO String
askfor3 prompt = do
  r <- liftIO $ do
    putStr $ "What is your " ++ prompt ++ " (type END to quit)?"
    getLine
  if r == "END"
    then mzero -- break out of the monad
    else return r -- continue, returning r
