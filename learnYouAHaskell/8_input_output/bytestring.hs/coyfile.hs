import System.Environment  
import qualified Data.ByteString.Lazy as B  

-- use lazy bytechunk with load chunks of 32kbit which is more efficient than the classic lazy string. Using strict bytestring would load all the file in memory.
main = do  
    (fileName1:fileName2:_) <- getArgs  
    copyFile fileName1 fileName2  
  
copyFile :: FilePath -> FilePath -> IO ()  
copyFile source dest = do  
    contents <- B.readFile source  
    B.writeFile dest contents 