import System.IO  
import Data.Char (toUpper)
  
main = do  
    contents <- readFile "input.txt"  
    let input = parse $ map (\x-> read x :: Int) $ lines contents
    let (a,b) = foldl (\(x,y) (a,b,c) -> (min (x+a) (y+b+c) ,min (y+b) (x+a+c))) (0,0) input
    putStrLn $ "Res = " ++ show (min a b)
    return ()

parse [] = []
parse [_] = error "cannot go here"
parse [a,b] = [(a,b,0)]
parse (a:b:c:q) = (a,b,c) : parse q


