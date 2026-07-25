class NFData a where -- reduce normal form
rnf :: a -> ()

data Tree a = Empty | Branch (Tree a) a (Tree a)
instance NFData a => NFData (Tree a) where
rnf Empty = ()
rnf (Branch l a r) = rnf l `seq ` rnf a `seq` rnf r

deepseq :: NFData a => a -> b -> b
deepseq a b = rnf a `seq` b

force :: NFData a => a -> a
force x = x `deepseq`x
