import Control.Monad
import Control.Monad.Except
import Control.Monad.Reader
import Control.Monad.State
import Control.Monad.Trans.Except
import Control.Monad.Trans.Maybe
import Data.Maybe (fromMaybe)
import System.Directory
import System.FilePath
import Text.Read (readMaybe)

type AMonadStack = ExceptT String (StateT Int (Reader String))

problem :: AMonadStack Int
problem = mzero

auxFun :: AMonadStack ()
auxFun = do
  state <- get
  when (state < 10) $ do
    put (state + 1)
    auxFun

deepNested :: AMonadStack ()
deepNested = do
  config <- ask
  auxFun
  when (config == "theo") $ throwError "Theo config"
  put 69

nested :: AMonadStack Int
nested = do
  _ <- deepNested
  state <- get
  when (state == 1) $ throwError "invalid state"
  return 0

app :: AMonadStack Int
app = do
  _ <- nested
  return 42

run = runReader (runStateT (runExceptT app) 0)