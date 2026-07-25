newtype Par a
instance Applicative Par
instance Monad Par

runPar :: Par a -> a

fork :: Par () -> Par ()


data IVar a -- instance Eq
new :: Par (IVar a)
put :: NFData a => IVar a -> a -> Par ()
get :: IVar a -> Par a


runPar $ do
	 i <- new --
	 j <- new --
	 fork (put i (fib n)) --
	 fork (put j (fib m)) --
	 a <- get i --
	 b <- get j --
	 return (a+b) --

spawn :: NFData a => Par a -> Par (IVar a)
spawn p = do
	 i <- new
	 fork (do x <- p; put i x)
	 return i

parMapM :: NFData b => (a -> Par b) -> [a] -> Par [b]
parMapM f as = do
	 ibs <- mapM (spawn . f) as
	 mapM get ibs
