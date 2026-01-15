infixr 5 :-:  -- We can define functions to be automatically infix by having them consist only of special characters. We can also do the same with constructors. 
-- infixr 5 specify the precedence
data List a = Empty | a :-: (List a) deriving (Show, Read, Eq, Ord)  

eg = 3 :-: 4 :-: 5 :-: Empty 

infixr 5  .++  
(.++) :: List a -> List a -> List a  
Empty .++ ys = ys  
(x :-: xs) .++ ys = x :-: (xs .++ ys)

a = 3 :-: 4 :-: 5 :-: Empty
b = 6 :-: 7 :-: Empty
c = a .++ b