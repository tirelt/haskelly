import Data.List
import Data.Char
{-
we have: 

instance Functor IO where  
    fmap f action = do  
        result <- action  
        return (f result)  

so we can use fmap directly on a IO action
-}
main = do line <- fmap reverse getLine  
          putStrLn $ "You said " ++ line ++ " backwards!"  
          putStrLn $ "Yes, you really said" ++ line ++ " backwards!" 
          line <- fmap (intersperse '-' . reverse . map toUpper) getLine  
          putStrLn line 

test1 = fmap (replicate 3) [1,2,3,4] 
test2 = fmap (replicate 3) (Right "blah")

{-
fmap :: (a -> b) -> (f a -> f b)
FUNCTOR LAW
1/ fmap id = id 
2/ fmap (f . g)  = fmap f . fmap g (equivalent to fmap (f . g) F = fmap f (fmap g F).) 
-}