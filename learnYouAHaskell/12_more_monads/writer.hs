import Data.Monoid  
import Control.Monad.Writer

isBigGang :: Int -> (Bool, String)  
isBigGang x = (x > 9, "Compared gang size to 9.")  


applyLog' :: (a,String) -> (a -> (b,String)) -> (b,String)  
applyLog' (x,log) f = let (y,newLog) = f x in (y,log ++ newLog)  


  
type Food = String  
type Price = Sum Int  
  
addDrink :: Food -> (Food,Price)  
addDrink "beans" = ("milk", Sum 25)  
addDrink "jerky" = ("whiskey", Sum 99)  
addDrink _ = ("beer", Sum 30)  

applyLog :: (Monoid m) => (a,m) -> (a -> (b,m)) -> (b,m)  
applyLog (x,log) f = let (y,newLog) = f x in (y,log `mappend` newLog)  
example1 =  ("dogmeat", Sum 5) `applyLog` addDrink `applyLog` addDrink  
example2 = ("jerky", Sum 25) `applyLog` addDrink 

{-
W5rriter type: pair of monad + monoid

newtype Writer w a = Writer { runWriter :: (a, w) }  

instance (Monoid w) => Monad (Writer w) where  
    return x = Writer (x, mempty)  
    (Writer (x,v)) >>= f = let (Writer (y, v')) = f x in Writer (y, v `mappend` v')  
-}

logNumber_ :: Int -> Writer [String] Int  
logNumber_ x = writer (x, ["Got number: " ++ show x])  
  
multWithLog :: Writer [String] Int  
multWithLog = do  
    a <- logNumber_ 3  
    b <- logNumber_ 5  
    tell ["Gonna multiply these two"] 
    return (b*a) 