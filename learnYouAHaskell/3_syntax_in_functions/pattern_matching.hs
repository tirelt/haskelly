lucky 7 = "LUCKY NUMBER SEVEN!"  
lucky x = "Sorry, you're out of luck, pal!"  

factorial 0 = 1  
factorial n = n * factorial (n - 1) 

addVectors (x1, y1) (x2, y2) = (x1 + x2, y1 + y2)  

head' :: [a] -> a  
head' [] = error "Can't call head on an empty list, dummy!"  
head' (x:_) = x  

length' [] = 0
length' (_:q) = 1 + length' q

-- matching but keeping the whole ref 
capital "" = "Empty string, whoops!"  
capital all@(x:xs) = "The first letter of " ++ all ++ " is " ++ [x]  

-- guards
-- otherwise = True so the last will always match
 
densityTell :: (RealFloat a) => a -> a -> String  
densityTell mass volume  
    | density < air = "Wow! You're going for a ride in the sky!"  
    | density <= water = "Have fun swimming, but watch out for sharks!"  
    | otherwise   = "If it's sink or swim, you're going to sink."  
    where density = mass / volume  
          air = 1.2  
          water = 1000.0  

-- where
{-
bind to variables at the end of a function and the whole function can see them, including all the guards
the names must be aligned in a single column
-}
initials firstname lastname = [f] ++ ". " ++ [l] ++ "."  
    where (f:_) = firstname  
          (l:_) = lastname  

calcDensities xs = [density m v | (m, v) <- xs]  
    where density mass volume = mass / volume  

-- let
{-
let bindings are expressions themselves
-}
cylinder r h = 
    let sideArea = 2 * pi * r * h  
        topArea = pi * r ^2  
    in  sideArea + 2 * topArea 

expressionExample = 4 * (let a = 9 in a + 1) + 2  

letFun = [let square x = x * x in (square 5, square 3, square 2)]  

severalVariables = (let a = 100; b = 200; c = 300 in a*b*c, let foo="Hey "; bar = "there!" in foo ++ bar)

patternMatch xs = [density | (m, v) <- xs, let density = m / v, density < 1.2]  

-- Patern matching in expression
describeList xs = "The list is " ++ case xs of [] -> "empty."  
                                               [x] -> "a singleton list."  
                                               xs -> "a longer list."  
-- equivalently 
describeList' xs = "The list is " ++ what xs  
    where what [] = "empty."  
          what [x] = "a singleton list."  
          what xs = "a longer list."  