import System.IO  
  
main = do  
    withFile "girlfriend.txt" ReadMode (\handle -> do  
        contents <- hGetContents handle  
        putStr contents)  

withFile' path mode f = do  
    handle <- openFile path mode  
    result <- f handle  
    hClose handle  
    return result 

--  hGetLine, hPutStr, hPutStrLn, hGetChar : same than the versoin with no h but take a Handle