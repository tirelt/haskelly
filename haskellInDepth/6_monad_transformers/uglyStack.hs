import Control.Monad
import Control.Monad.Reader
import Control.Monad.State
import System.Directory
import System.FilePath

data AppConfig = AppConfig {cfgMaxDepth :: Int}
  deriving (Show)

data AppState = AppState {stDeepestReached :: Int}
  deriving (Show)

-- type App = ReaderT AppConfig (StateT AppState IO)
type App = StateT AppState (ReaderT AppConfig IO)

runApp :: App a -> Int -> IO (a, AppState)
runApp k maxDepth =
  let config = AppConfig maxDepth
      state = AppState 0
   in --   in runStateT (runReaderT k config) state
      runReaderT (runStateT k state) config

constrainedCount :: Int -> FilePath -> App [(FilePath, Int)]
constrainedCount curDepth path = do
  contents <- liftIO . listDirectory $ path
  cfg <- ask
  rest <- forM contents $ \name -> do
    let newPath = path </> name
    isDir <- liftIO $ doesDirectoryExist newPath
    if isDir && curDepth < cfgMaxDepth cfg
      then do
        let newDepth = curDepth + 1
        st <- get
        when (stDeepestReached st < newDepth) $
          put st {stDeepestReached = newDepth}
        constrainedCount newDepth newPath
      else return []
  return $ (path, length contents) : concat rest