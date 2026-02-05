import Control.Monad.State

{-
class Monad m => MonadState s m | m -> s where
get :: m s
put :: s -> m ()
state :: (s -> (a, s)) -> m a

modify :: MonadState s m => (s -> s) -> m ()
gets :: MonadState s m => (s -> a) -> m a

runState :: State s a -> s -> (a, s)
execState :: State s a -> s -> s
evalState :: State s a -> s -> a

mapState :: ((a, s) -> (b, s)) -> State s a -> State s b
withState :: (s -> s) -> State s a -> State s a
-}

addItem :: Integer -> State Integer ()
addItem n = do
  s <- get
  put (s + n)

addItem' :: Integer -> State Integer ()
addItem' n = modify' (+ n)

sumList :: [Integer] -> State Integer ()
sumList xs = traverse_ addItem xs