data Person = Person { firstName :: String  
                     , lastName :: String  
                     , age :: Int  
                     , height :: Float  
                     , phoneNumber :: String  
                     , flavor :: String  
                     } deriving (Show) 

data Car = Car {company :: String, model :: String, year :: Int} deriving (Show)

car = Car {company="Ford", model="Mustang", year=1967} 
otherCar = Car "Ford" "Mustang" 1967  
