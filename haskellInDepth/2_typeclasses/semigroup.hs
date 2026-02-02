{-
(<>) :: Semigroup a => a -> a -> a
sconcat :: Semigroup a => NonEmpty a -> a

Product 2 <> Product 3
Product {getProduct = 6}

[1,2,3] <> [4,5,6]
[1,2,3,4,5,6]
-}