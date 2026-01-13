import Control.Monad  
  
main = do  
    c <- getChar  
    when (c /= ' ') $ do   -- when is a normal function which returns the do operation when True and () if false
        putChar c  
        main 
-- it’s useful for encapsulating the if something then do some I/O action else return ()