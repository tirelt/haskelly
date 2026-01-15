import Data.Monoid
{-
A monoid is when you have an associative binary function and a value which acts as an identity with respect to that function


class Monoid m where  
    mempty :: m  
    mappend :: m -> m -> m  
    mconcat :: [m] -> m  
    mconcat = foldr mappend mempty 

Monoid law

1/ mempty `mappend` x = x
2/ x `mappend` mempty = x
3/ (x `mappend` y) `mappend` z = x `mappend` (y `mappend` z)


instance Monoid [a] where  
    mempty = []  
    mappend = (++)  

newtype Product a =  Product { getProduct :: a }  
    deriving (Eq, Ord, Read, Show, Bounded)  

instance Num a => Monoid (Product a) where  
    mempty = Product 1  
    Product x `mappend` Product y = Product (x * y) 
-}

productExample = getProduct $ Product 3 `mappend` Product 9 
sumExmaple = getSum $ mempty `mappend` Sum 3

{-
newtype Any = Any { getAny :: Bool }  
    deriving (Eq, Ord, Read, Show, Bounded)  
instance Monoid Any where  
        mempty = Any False  
        Any x `mappend` Any y = Any (x || y)  

newtype All = All { getAll :: Bool }  
        deriving (Eq, Ord, Read, Show, Bounded)  
instance Monoid All where  
        mempty = All True  
        All x `mappend` All y = All (x && y)  

Ordering type (result of compare) is also a Monoid

instance Monoid Ordering where  
    mempty = EQ  
    LT `mappend` _ = LT  
    EQ `mappend` y = y  
    GT `mappend` _ = GT  

The Ordering monoid is very cool because it allows us to easily compare things by many different criteria 
and put those criteria in an order themselves, ranging from the most important to the least.


instance Monoid a => Monoid (Maybe a) where  
    mempty = Nothing  
    Nothing `mappend` m = m  
    m `mappend` Nothing = m  
    Just m1 `mappend` Just m2 = Just (m1 `mappend` m2)  

newtype First a = First { getFirst :: Maybe a }  
    deriving (Eq, Ord, Read, Show)  
instance Monoid (First a) where  
    mempty = First Nothing  
    First (Just x) `mappend` _ = First (Just x)  
    First Nothing `mappend` x = x  

First is useful when we have a bunch of Maybe values and we just want to know if any of them is a Just. The mconcat function comes in handy
-}

firstExample = getFirst . mconcat . map First $ [Nothing, Just 9, Just 10]  
lastExample = getLast . mconcat . map Last $ [Nothing, Just 9, Just 10]