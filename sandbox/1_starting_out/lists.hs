takeExample = take 10 (cycle [1,2,3])  

replicateExample = replicate 2 10

repeatExample = take 10 (repeat 6)

lengthExample = length [5,4,3,2,1]  

nullExample = null [1,2,3] 

reverseExample = reverse [5,4,3,2,1] 

dropExample = drop 3 [8,4,2,1,5,6]

minMaxExample = (minimum [8,4,2,1,5,6],maximum [1,9,2,3,4])

opExample = (sum [5,2,1,6,3,2,5,7],product [6,2,1,2])

-- can also use elem 4 [3,4,5,6]
elemExample = 4 `elem` [3,4,5,6]

listManip = (head [5,4,3,2,1],tail [5,4,3,2,1],last [5,4,3,2,1],init [5,4,3,2,1])

listConcat = [1,2,3,4] ++ [9,10,11,12]  

listAppend = 1:2:3:[4,5]

getElement = [9.4,33.2,96.2,11.2,23.25] !! 1 