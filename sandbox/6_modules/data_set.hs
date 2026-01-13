import qualified Data.Set as Set  -- also implemented as trees, unique 
import qualified Distribution.Simple as Set

set1 = Set.fromList "I just had an anime dream. Anime... Reality... Are they so different?" 
set2 = Set.fromList "The old man left his garbage can out and now his trash is all over my lawn!" 

intersectionExample = Set.intersection set1 set2

differenceExample = Set.difference set1 set2 

unionExample = Set.union set1 set2  

-- null, size, member, empty, singleton, insert and delete: same than for Map
nullEmptyExample = Set.null Set.empty

isSubsetOfExample = Set.fromList [2,3,4] `Set.isSubsetOf` Set.fromList [1,2,3,4,5]

-- map and filter works as expected 