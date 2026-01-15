{-
class Monad m where  
    return :: a -> m a  
  
    (>>=) :: m a -> (a -> m b) -> m b  
  
    (>>) :: m a -> m b -> m b  
    x >> y = x >>= \_ -> y  
  
    fail :: String -> m a  
    fail msg = error msg

instance Monad Maybe where  
    return x = Just x  
    Nothing >>= f = Nothing  
    Just x >>= f  = f x  
    fail _ = Nothing
-}

type Birds = Int  
type Pole = (Birds,Birds)  

landLeft :: Birds -> Pole -> Pole 
landLeft n (left,right) = (left + n,right) 

landRight :: Birds -> Pole -> Pole  
landRight n (left,right) = (left,right + n) 

x -: f = f x  

neat = (0,0) -: landLeft 1 -: landRight 1 -: landLeft 2 


landLeft' :: Birds -> Pole -> Maybe Pole  
landLeft' n (left,right)  
    | abs ((left + n) - right) < 4 = Just (left + n, right)  
    | otherwise                    = Nothing  
  
landRight' :: Birds -> Pole -> Maybe Pole  
landRight' n (left,right)  
    | abs (left - (right + n)) < 4 = Just (left, right + n)  
    | otherwise                    = Nothing  

better = return (0,0) >>= landRight' 2 >>= landLeft' 2>>= landRight' 2 

banana :: Pole -> Maybe Pole  
banana _ = Nothing

whoops = return (0,0) >>= landLeft' 1 >>= banana >>= landRight' 1
whoops2 = return (0,0) >>= landLeft' 1 >> Nothing >>= landRight' 1

{-
Monad law
1/ return x >>= f == f x
2/ m >>= return == m
2/ (m >>= f) >>= g == m >>= (\x -> f x >>= g)
-}