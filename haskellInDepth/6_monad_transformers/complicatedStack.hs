import Control.Monad
import Control.Monad.Reader
import Control.Monad.State
import Control.Monad.Trans.Maybe
import Data.Maybe (fromMaybe)
import System.Directory
import System.FilePath
import Text.Read (readMaybe)

type AMonadStack = StateT Int (ReaderT Int (ReaderT String IO))

testAux :: Int -> AMonadStack ()
testAux add = do
  cumsum <- get
  mult <- ask
  let newCumsum = cumsum + mult * add
  put newCumsum

test :: AMonadStack ()
test = do
  cumsum <- get
  when (cumsum < 10) $ do
    input <- liftIO getLine
    let add = fromMaybe 0 (readMaybe input)
    prompt <- lift . lift $ asks (++ " tttt")
    testAux add
    test

run :: Int -> String -> IO ((), Int)
run mult = runReaderT (runReaderT (runStateT test 0) mult)