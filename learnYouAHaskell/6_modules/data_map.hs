import qualified Data.Map as Map -- implemented using trees so keys must be Orderable 
import Data.Char (isUpper)
fromListExample = Map.fromList [("amelia","555-2938"),("freya","452-2928"),("neil","205-2928")]  -- dupes are discarded

emptyExample = Map.empty 

insertExample = Map.insert 5 600 . Map.insert 4 200 . Map.insert 3 100 $ Map.empty

nullExamle = Map.null $ Map.fromList [(2,3),(5,5)] 

sizeExample = Map.size $ Map.fromList [(2,4),(3,3),(4,2),(5,4),(6,4)]

singletonExample = Map.singleton 3 9 


lookupExample = Map.lookup 3 $ Map.fromList [(3,6),(4,3),(6,9)] 
memnberExample = Map.member 3 $ Map.fromList [(3,6),(4,3),(6,9)]


mapExample = Map.map (*100) $ Map.fromList [(1,1),(2,4),(3,9)]  
filterExample = Map.filter isUpper $ Map.fromList [(1,'a'),(2,'A'),(3,'b'),(4,'B')] 

toListExample = Map.toList . Map.insert 9 2 $ Map.singleton 4 3

-- keys, elems to get the list of keys and elements
 
-- fromListWith : doesn't discard dupers but apply function to them
fromListWithExample = 
    let  phoneBook = 
            [("amelia","555-2938")  
            ,("amelia","342-2492")  
            ,("freya","452-2928")  
            ,("isabella","493-2928")  
            ,("isabella","943-2929")  
            ,("isabella","827-9162")  
            ,("neil","205-2928")  
            ,("roald","939-8282")  
            ,("tenzing","853-2492")  
            ,("tenzing","555-2111")
            ] 
    in Map.fromListWith (\number1 number2 -> number1 ++ ", " ++ number2) phoneBook

insertWithExample = Map.insertWith (+) 3 100 $ Map.fromList [(3,4),(5,103),(6,339)] 
