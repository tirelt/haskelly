import Control.Monad (forM_, when)
import Control.Monad.Trans (liftIO)
import Control.Monad.Writer (WriterT, tell)
import System.Directory (doesDirectoryExist, getDirectoryContents)
import System.FilePath ((</>))

listDirectory :: FilePath -> IO [String]
listDirectory = fmap (filter notDots) . getDirectoryContents
  where
    notDots p = p /= "." && p /= ".."

countEntries :: FilePath -> WriterT [(FilePath, Int)] IO ()
countEntries path = do
  contents <- liftIO . listDirectory $ path
  tell [(path, length contents)]
  forM_ contents $ \name -> do
    let newName = path </> name
    isDir <- liftIO . doesDirectoryExist $ newName
    when isDir $ countEntries newName