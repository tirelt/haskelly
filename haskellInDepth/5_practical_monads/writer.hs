{-
class (Monoid w, Monad m) => MonadWriter w m | m -> w where
writer :: (a, w) -> m a
tell :: w -> m ()
listen :: m a -> m (a, w)
pass :: m (a, w -> w) -> m a

listens :: MonadWriter w m => (w -> b) -> m a -> m (a, b)
censor :: MonadWriter w m => (w -> w) -> m a -> m a

listens :: MonadWriter w m => (w -> b) -> m a -> m (a, b)
censor :: MonadWriter w m => (w -> w) -> m a -> m a

runWriter :: Writer w a -> (a, w)
execWriter :: Writer w a -> w
-}
