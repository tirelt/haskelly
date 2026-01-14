data Person = Person { firstName :: String  
                     , lastName :: String  
                     , age :: Int  
                     } deriving (Eq, Show, Read)   

mikeD = read "Person {firstName =\"Michael\", lastName =\"Diamond\", age = 43}" :: Person  

-- with Ord, in algebraic type the first variant is always less than the second 

data Day = Monday | Tuesday | Wednesday | Thursday | Friday | Saturday | Sunday  
           deriving (Eq, Ord, Show, Read, Bounded, Enum)  

sat = read "Saturday" :: Day

comp = Saturday > Friday

next = succ Monday

bounds = [minBound .. maxBound] :: [Day]

range = [Thursday .. Sunday]