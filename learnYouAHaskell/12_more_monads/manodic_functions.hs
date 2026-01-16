import Control.Monad
import Control.Monad.Writer
{-
liftM :: (Monad m) => (a -> b) -> m a -> m b  

take a normal function and apply it though a monad

liftM :: (Monad m) => (a -> b) -> m a -> m b  
liftM f m = m >>= (\x -> return (f x))  

equivalent 
liftM f m = do 
    x <- m
    return (f x)

also we can implement the <*> for appicative functor like this 
ap :: (Monad m) => m (a -> b) -> m a -> m b  
ap mf m = do  
    f <- mf  
    x <- m  
    return (f x)  
-}

simpleExamle = liftM (*3) (Just 8)  
equivalent = fmap (*3) (Just 8)


nice = runWriter $ liftM not $ writer (True, "chickpeas")

{-
liftA2 :: (Applicative f) => (a -> b -> c) -> f a -> f b -> f c  
liftA2 f x y = f <$> x <*> y  

similarly 
liftM2, liftM3  liftM4 and liftM5 exist for monad
-}

{-
join :: (Monad m) => m (m a) -> m a  

join :: (Monad m) => m (m a) -> m a  
join mm = do  
    m <- mm  
    m  
-}

joinExample = join (Just (Just 9))  

{-
filterM :: (Monad m) => (a -> m Bool) -> [a] -> m [a]  
-}

keepSmall :: Int -> Writer [String] Bool  
keepSmall x  
    | x < 4 = do  
        tell ["Keeping " ++ show x]  
        return True  
    | otherwise = do  
        tell [show x ++ " is too large, throwing it away"]  
        return False

res = fst $ runWriter $ filterM keepSmall [9,1,5,2,10,3]   

showing = mapM_ putStrLn $ snd $ runWriter $ filterM keepSmall [9,1,5,2,10,3]  

powerset :: [a] -> [[a]]  
powerset = filterM (\x -> [True, False])

powerSetRes = powerset [1,2,3]

{-
foldM :: (Monad m) => (a -> b -> m a) -> a -> [b] -> m a  
-}

binSmalls :: Int -> Int -> Maybe Int  
binSmalls acc x  
    | x > 9     = Nothing  
    | otherwise = Just (acc + x) 

foldMExample = foldM binSmalls 0 [2,8,3,1] 