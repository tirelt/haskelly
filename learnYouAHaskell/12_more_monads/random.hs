import System.Random  
import Control.Monad.State  
{-
random :: (RandomGen g, Random a) => g -> (a, g)  
-}
  
randomSt :: (RandomGen g, Random a) => State g a  
randomSt = State random  

threeCoins :: State StdGen (Bool,Bool,Bool)  
threeCoins = do  
    a <- randomSt  
    b <- randomSt  
    c <- randomSt  
    return (a,b,c) 

threeCoin = runState threeCoins (mkStdGen 33)  