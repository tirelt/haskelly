import Data.Function
onExample :: Integer -> Integer -> Integer
onExample = min `on` abs -- on :: (b -> b -> c) -> (a -> b) -> a -> a -> c  