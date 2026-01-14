import Control.Monad  
import Data.Char  
  
main = forever $ do   -- repeat the do forever
    putStr "Give me some input: "  
    l <- getLine  
    putStrLn $ map toUpper l 