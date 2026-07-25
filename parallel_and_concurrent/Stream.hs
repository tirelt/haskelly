{-# LANGUAGE BangPatterns #-}

module Main where

main :: IO ()
main = pure ()

data IList a
  = Nil
  | Cons a (IVar (IList a))

type Stream a = IVar (IList a)

data IVar a

data Par a = Par (IO a)

instance Functor Par where
  fmap f (Par io) = Par (fmap f io)

instance Applicative Par where
  pure = Par . pure
  Par f <*> Par a = Par (f <*> a)

instance Monad Par where
  Par m >>= k = Par (m >>= unPar . k)
    where unPar (Par x) = x

class NFData a

instance NFData a => NFData (IList a)

new :: Par (IVar a)
new = error "new: not implemented"

fork :: Par () -> Par ()
fork = error "fork: not implemented"

put :: IVar a -> a -> Par ()
put = error "put: not implemented"

get :: IVar a -> Par a
get = error "get: not implemented"

streamFromList :: NFData a => [a] -> Par (Stream a)
streamFromList xs = do
  var <- new
  fork $ loop xs var
  return var
  where
    loop [] var = put var Nil
    loop (x:xs) var = do
      tail <- new
      put var (Cons x tail)
      loop xs tail

streamFold :: (a -> b -> a) -> a -> Stream b -> Par a
streamFold fn !acc instrm = do
  ilst <- get instrm
  case ilst of
    Nil -> return acc
    Cons h t -> streamFold fn (fn acc h) t

streamMap :: NFData b => (a -> b) -> Stream a -> Par (Stream b)
streamMap fn instrm = do
  outstrm <- new
  fork $ loop instrm outstrm
  return outstrm
  where
    loop instrm outstrm = do
      ilst <- get instrm
      case ilst of
        Nil -> put outstrm Nil
        Cons h t -> do
          newtl <- new
          put outstrm (Cons (fn h) newtl)
          loop t newtl
