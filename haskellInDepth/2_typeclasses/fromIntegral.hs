{-
The fromIntegral function allows us to treat any integral value as a value of arbitrary
numeric type (a type with Num instance)

fromIntegral :: (Integral a, Num b) => a -> b

The fromIntegral function is actually unsafe and should be used
with care. The problem is that this function doesn’t check for underflows and
overflows in data
-}
xs = [1..10]
mean = fromIntegral (sum xs) / fromIntegral (length xs)