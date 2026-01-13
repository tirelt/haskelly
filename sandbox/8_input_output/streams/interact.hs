main = interact shortLinesOnly -- no do needed ? equivalent to getContents and run a String->String function on it  
  
shortLinesOnly input = 
    let allLines = lines input  
        shortLines = filter (\line -> length line < 10) allLines  
        result = unlines shortLines  
    in  result 