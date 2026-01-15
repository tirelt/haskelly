--import Control.Applicative
import Control.Applicative (ZipList(..),liftA2)

compareExample :: Maybe (Char -> Ordering)
compareExample = fmap compare (Just 'a')

multFunctor =  fmap (*) [1,2,3,4]
a = map (\x -> x 9) multFunctor 

{-
class (Functor f) => Applicative' f where  
    pure :: a -> f a  
    (<*>) :: f (a -> b) -> f a -> f b  

instance Applicative' Maybe where  
    pure = Just  
    Nothing <*> _ = Nothing  
    (Just f) <*> something = fmap f something 
-}
{-
essentially define an application that works through a functor
ghci> Just (+3) <*> Just 9  
Just 12  
ghci> pure (+3) <*> Just 10  
Just 13  
ghci> pure (+3) <*> Just 9  
Just 12  
ghci> Just (++"hahah") <*> Nothing  
Nothing  
ghci> Nothing <*> Just "woot"  
Nothing  
-}

f <$> x = fmap f x

so = (++) Prelude.<$> Just "johntra" <*> Just "volta"  
{-
instance Applicative [] where  
    pure x = [x]  
    fs <*> xs = [f x | f <- fs, x <- xs]  
-}

listExmaple = [(*0),(+100),(^2)] <*> [1,2,3]
listExmaple2 = (*0) Prelude.<$> [1,2,3]

{-
instance Applicative IO where  
    pure = return  
    a <*> b = do  
        f <- a  
        x <- b  
        return (f x)
-}
myAction = (++) Prelude.<$> getLine <*> getLine -- contenate in an IO action two getline 

{-
instance Applicative ((->) r) where  
    pure x = (\_ -> x)  
    f <*> g = \x -> f x (g x)  
-}
applicativeOnfunction = (\x y z -> [x,y,z]) Prelude.<$> (+3) <*> (*2) <*> (/2) $ 5  -- [8.0,10.0,2.5]  

{-
instance Applicative ZipList where  
        pure x = ZipList (repeat x)  
        ZipList fs <*> ZipList xs = ZipList (zipWith (\f x -> f x) fs xs)
-}

zipListexample = getZipList $ (+) Prelude.<$> ZipList [1,2,3] <*> ZipList [100,100,100] -- <*> ZipList apply first el with first, snd with snd etc. (no cross product)

liftA2Example = liftA2 (:) (Just 3) (Just [4]) -- equivalent to (:) <$> Just 3 <*> Just [4]

sequenceA :: (Applicative f) => [f a] -> f [a] 
sequenceA = foldr (liftA2 (:)) (pure [])
 
sequenceAExample = Main.sequenceA [Just 3, Just 2, Just 1]  -- Just [3,2,1] 

{- 
Applicative functor law 
pure f <*> x = fmap f x
pure id <*> v = v
pure (.) <*> u <*> v <*> w = u <*> (v <*> w)
pure f <*> pure x = pure (f x)
u <*> pure y = pure ($ y) <*> u
-}
getThreeLine = Main.sequenceA [getLine, getLine, getLine]   -- get three line in a OI [String]