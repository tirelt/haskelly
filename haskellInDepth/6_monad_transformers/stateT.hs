import Control.Monad
import Control.Monad.State

type Stack = [Integer]

type EvalM = StateT Stack Maybe

push :: Integer -> EvalM ()
push x = modify (x :)

{-
lift :: (MonadTrans t, Monad m) => m a -> t m a
lift :: Maybe a -> (StateT Stack) Maybe a
-}
pop :: EvalM Integer
pop = do
  xs <- get
  when (null xs) $ lift Nothing
  put (tail xs)
  pure (head xs)