import Data.List  
import Control.Monad
  
solveRPN :: String -> Double  
solveRPN = head . foldl foldingFunction [] . words

foldingFunction :: [Double] -> String -> [Double]  
foldingFunction (x:y:ys) "*" = (x * y):ys  
foldingFunction (x:y:ys) "+" = (x + y):ys  
foldingFunction (x:y:ys) "-" = (y - x):ys  
foldingFunction xs numberString = read numberString:xs  

readMaybe :: (Read a) => String -> Maybe a  
readMaybe st = case reads st of [(x,"")] -> Just x  
                                _ -> Nothing  

foldingFunctionSafe :: [Double] -> String -> Maybe [Double]  
foldingFunctionSafe (x:y:ys) "*" = return ((x * y):ys)  
foldingFunctionSafe (x:y:ys) "+" = return ((x + y):ys)  
foldingFunctionSafe (x:y:ys) "-" = return ((y - x):ys)  
foldingFunctionSafe xs numberString = liftM (:xs) (readMaybe numberString)  

solveRPNSafe :: String -> Maybe Double  
solveRPNSafe st = do  
    [result] <- foldM foldingFunctionSafe [] (words st)  
    return result  

nothingExample = solveRPN "1 2 * 4"  
justExmaple = solveRPN "1 2 * 4 + 5 *"  

{-
composing monadic function 
-}

g = (\x -> return (x+1) :: Maybe Int) <=< (\x -> return (x*100)) 
calc = Just 4 >>= g
-- equivalent to f = (+1) . (*100) but for Mondaic values

crazy = foldr (.) id [(+1),(*100),(+1)]  