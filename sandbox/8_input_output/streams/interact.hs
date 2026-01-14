main = interact shortLinesOnly -- no do needed ? -> yes just one line in main, equivalent to getContents and run a String->String function on it  
  
shortLinesOnly input = 
    let allLines = lines input  
        shortLines = filter (\line -> length line < 10) allLines  
        result = unlines shortLines  
    in  result 