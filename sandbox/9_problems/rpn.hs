import Data.Char 
solveRPN xs = let l = words xs in calc l [] 
calc [] [] = 0
calc [] [n] = n
calc [] stack = error "too many operands"
calc (a:b) stack
    | all isDigit a = calc b $ (read a :: Int) : stack
    | otherwise = let (res, new_stack) = calcAux a stack in calc b $ res:new_stack

calcAux "*" (a:b:q) = (a * b,q)
calcAux "+" (a:b:q) = (a + b,q)
calcAux "-" (a:b:q) = (b - a,q)
calcAux "/" (a:b:q) = (a `div` b,q)
calcAux op (a:b:q) = error "unsupported operator"
calcAux op s = error "not enought operands"

solveRPN' = head . foldl foldingFunction [] . words  
    where   foldingFunction (x:y:ys) "*" = (x * y):ys  
            foldingFunction (x:y:ys) "+" = (x + y):ys  
            foldingFunction (x:y:ys) "-" = (y - x):ys  
            foldingFunction xs numberString = read numberString:xs  