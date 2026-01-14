
import System.Environment  
import System.Directory  
import System.IO  
import Data.List  
  
dispatch :: [(String, [String] -> IO ())]  
dispatch =  [ ("add", add)  
            , ("view", view)  
            , ("remove", remove)
            , ("create", create)
            , ("bump", bump)
            ]  
main = do  
    (command:args) <- getArgs  
    let (Just action) = lookup command dispatch  
    action args  

add [fileName, todoItem] = appendFile fileName (todoItem ++ "\n")  

bump [fileName, todoItem] = do 
    handle <- openFile fileName ReadMode  
    (tempName, tempHandle) <- openTempFile "." "temp"  
    contents <- hGetContents handle
    hPutStr tempHandle $ todoItem ++ "\n" ++ contents
    hClose handle  
    hClose tempHandle  
    removeFile fileName  
    renameFile tempName fileName

create [fileName] = writeFile fileName ""

view [fileName] = do  
    contents <- readFile fileName  
    let todoTasks = lines contents  
        numberedTasks = zipWith (\n line -> show n ++ " - " ++ line) [0..] todoTasks  
    putStr $ unlines numberedTasks 

remove [fileName, numberString] = do  
    handle <- openFile fileName ReadMode  
    (tempName, tempHandle) <- openTempFile "." "temp"  
    contents <- hGetContents handle  
    let number = read numberString  
        todoTasks = lines contents  
        newTodoItems = delete (todoTasks !! number) todoTasks  
    hPutStr tempHandle $ unlines newTodoItems  
    hClose handle  
    hClose tempHandle  
    removeFile fileName  
    renameFile tempName fileName