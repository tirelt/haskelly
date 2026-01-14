applyTwice f x = f (f x)  

zipWith' _ [] _ = []  
zipWith' _ _ [] = []  
zipWith' f (x:xs) (y:ys) = f x y : zipWith' f xs ys  

flip' f = g  
    where g x y = f y x  

mapExample = map (+3) [1,5,3,1,6] 

filterExample = filter (>3) [1,5,3,2,1,6,4,3,2,1]

largestDivisible = head (filter f [100000,99999..])  
    where f x = x `mod` 3829 == 0  

solution1 = sum (takeWhile (<10000) (filter odd (map (^2) [1..])))  

solution2  = sum (takeWhile (<10000) [n^2 | n <- [1..], odd (n^2)]) 

collatzSeq 1 = [1]
collatzSeq n 
    | even n = n : collatzSeq (n `div` 2)
    | otherwise = n : collatzSeq (n * 3 + 1) 

res = length (filter (>15) (map f [1..100]))
    where 
        f x = length (collatzSeq x)
    

lambdaExample = zipWith (\a b -> (a * 30 + 3) / b) [5,4,3,2,1] [1,2,3,4,5] 
patternLambda = map (\(a,b) -> a + b) [(1,2),(3,5),(6,3),(2,6),(2,5)]  

addThree = \x -> \y -> \z -> x + y + z