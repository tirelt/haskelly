import Control.Monad.State

type Stack = [Int]  
  
pop' :: Stack -> (Int,Stack)  
pop' (x:xs) = (x,xs)  
  
push' :: Int -> Stack -> ((),Stack)  
push' a xs = ((),a:xs) 

stackManip' :: Stack -> (Int, Stack)  
stackManip' stack = let  
    ((),newStack1) = push' 3 stack  
    (a ,newStack2) = pop' newStack1  
    in pop' newStack2  

{-
newtype State s a = State { runState :: s -> (a,s) } 
instance Monad (State s) where  
    return x = State $ \s -> (x,s)  
    (State h) >>= f = State $ \s -> let (a, newState) = h s  
                                        (State g) = f a  
                                    in  g newState  
-}

pop :: State Stack Int  
pop = state $ \(x:xs) -> (x,xs)  
  
push :: Int -> State Stack ()  
push a = state $ \xs -> ((),a:xs) 

stackManip :: State Stack Int  
stackManip = do  
    pop  
    pop
    --a <- pop  
    --pop  

test :: (Int, Stack)
test = runState stackManip [5,8,2,1]
stackStuff = do  
    a <- pop  
    if a == 5  
        then push 5  
        else do  
            push 3  
            push 8  

moreStack = do  
    a <- stackManip  
    if a == 100  
        then stackStuff  
        else return ()  

{-
get = State $ \s -> (s,s)  
put newState = State $ \s -> ((),newState) 
-}

stackyStack :: State Stack ()  
stackyStack = do  
    stackNow <- get  
    if stackNow == [1,2,3]  
        then put [8,3,1]  
        else put [9,2,1]  