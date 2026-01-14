import System.Environment  
import System.IO  
import System.IO.Error  
main = do toTry `catchIOError` handler1  
          thenTryThis `catchIOError` handler2  
          launchRockets  