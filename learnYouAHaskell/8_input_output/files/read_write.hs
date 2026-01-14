import System.IO  
import Data.Char (toUpper)
  
main = do  
    contents <- readFile "girlfriend.txt"  
    writeFile "girlfriendcaps.txt" (map toUpper contents) 

