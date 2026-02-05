class (Monad m) => MonadFail (m :: * -> *)
    fail :: String -> m a