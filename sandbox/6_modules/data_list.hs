import Data.List  
import Data.Function (on)
{-
import Data.List (nub, sort)  -- just import nub and sort
import Data.List hiding (nub)  -- import everything but nub
-}  
import qualified Data.Map  -- to import with name space e.g. Data.Map.filter
{-
import qualified Data.Map as M  -- to use M.filter
-}
numUniques :: (Eq a) => [a] -> Int  
numUniques = length . nub  

intersperseExample = intersperse '.' "MONKEY" 

intercalateExample = intercalate [0,0,0] [[1,2,3],[4,5,6],[7,8,9]]  

transposeExample = transpose [[1,2,3],[4,5,6],[7,8,9]] 
transposeExample2 = transpose ["hey","there","folks"] 

-- foldl' and foldr': stricter version which are not lazy about calculating the accumulator. good if we can stack overflow error using normal foldr foldl

exampleConcat = concat [[3,4,5],[2,3,4],[2,1,1]] -- to flatten a list of list (or list of string) 

exampleConcatMap  = concatMap (replicate 4) [1..3] 

exampleAnd = and $ map (>4) [5,6,7,8]  
exampleOr = or $ map (==4) [2,3,4,5,6,1]  
exampleAny = any (==4) [2,3,5,6,1,4]  
exampleAll = all (>4) [6,9,10]

iterateExample = take 10 $ iterate (*2) 1 

splitAtExample = splitAt 3 "heyman"

dropWhileExaple = dropWhile (<3) [1,2,2,2,3,4,5,4,3,2,1] 

spanExample = let (fw, rest) = span (/=' ') "This is a sentence" in "First word:" ++ fw ++ ", the rest:" ++ rest -- split in takeWhile and dropWhile
breakExample = break (==4) [1,2,3,4,5,6,7] -- split into two list, one where the predicate is false, and one where it becomes true for the first time and the remaining values  

sortExample = sort [8,5,3,2,1,6,4,2]

groupExample = group [1,1,1,1,2,2,2,2,3,3,2,2,2,5,6,7] --groups adjacent elements into sublists if they are equal 

initsTailsExample = let w = "w00t" in zip (inits w) (tails w) 

search needle haystack = 
    let nlen = length needle  
    in  foldl (\acc x -> take nlen x == needle || acc) False (tails haystack) 

isInfixOfExample = "cat" `isInfixOf` "im a cat burglar" 

isPrefixOfExample = "hey" `isPrefixOf` "hey there!" 
isSuffixOfExample = "there!" `isSuffixOf` "oh hey there!" 

-- elem, notElem

examplePartition = partition (>3) [1,3,5,6,3,2,1,0,3,7]

findExample = find (>4) [1,2,3,4,5,6] -- returns Maybe of the first value 

elemIndexExample = 4 `elemIndex` [1,2,3,4,5,6] -- returns Maybe of the index of the value 

findIndexExample = findIndex (>7) [5,3,2,1,6,4] -- Maybe of the first index 
findIndicesExample = findIndices (`elem` ['A'..'Z']) "Where Are The Caps?"

-- zip3, zip4, etc. and zipWith3, zipWith4

linesExample = lines "first line\nsecond line\nthird line"  --split lines 
-- contratry is unlines

wordsExample = words "hey these are the words in this sentence"
unwordsExample = unwords ["hey","there","mate"]

nubExample = nub [1,2,3,4,3,2,1,2,3,4,3,2,1] -- remove dupes 

deleteExample = delete 'h' "hey there ghang!" --  deletes the first occurrence of that element in the list.

differenceExample = [1..10] \\ [2,5,9] -- acts like a set difference 

unionExample = [1..7] `union` [5..10]  
intersectExample = [1..7] `intersect` [5..10] 

insertExample = insert 4 [3,5,1,2,8,2] -- insert an element before a value >= element 

-- genericLength, genericTake, genericDrop, genericSplitAt, genericIndex and genericReplicate do the same as the non generic but use typeclass Num instead of Int

-- nubBy, deleteBy, unionBy, intersectBy and groupBy use a function instead of (==)

-- similarly sortBy, insertBy, maximumBy and minimumBy take a function that determine if one element is greater, smaller or equal to the othe

sortByExample = let xs = [[5,4,5,4,4],[1,2,3],[3,5,4,3],[],[2],[2,2]] in  sortBy (compare `on` length) xs 