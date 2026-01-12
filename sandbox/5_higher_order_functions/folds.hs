sum' :: (Num a) => [a] -> a  
sum' = foldl (+) 1

elem' :: (Foldable t, Eq a) => a -> t a -> Bool
elem' y  = foldl (\acc x -> (x==y)|| acc) False 

map' :: Foldable t1 => (t2 -> a) -> t1 t2 -> [a]
map' f = foldr (\x acc -> f x : acc) []

-- foldr1 and foldl1, start with acc = the first / last element
maximum' :: (Ord a) => [a] -> a  
maximum' = foldr1 (\x acc -> if x > acc then x else acc)  
  
reverse' :: [a] -> [a]  
reverse' = foldl (\acc x -> x : acc) []  
  
product' :: (Num a) => [a] -> a  
product' = foldr1 (*)  
  
filter' :: (a -> Bool) -> [a] -> [a]  
filter' p = foldr (\x acc -> if p x then x : acc else acc) []  
  
head' :: [a] -> a  
head' = foldr1 (\x _ -> x)  
  
last' :: [a] -> a  
last' = foldl1 (\_ x -> x) 

scanlExample = scanl (+) 0 [3,5,2,1]  
scanl1Example = scanl1 (\acc x -> if x > acc then x else acc) [3,4,5,3,7,9,2,1]

sqrtSums = length (takeWhile (<1000) (scanl1 (+) (map sqrt [1..]))) + 1 