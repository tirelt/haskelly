-- like C++ template 
data Maybe a = Nothing | Just a  
data Vector a = Vector a a a deriving (Show)  
  
(Vector i j k) `vplus` (Vector l m n) = Vector (i+l) (j+m) (k+n)  
  
(Vector i j k) `vectMult` m = Vector (i*m) (j*m) (k*m)  
  
(Vector i j k) `scalarMult` (Vector l m n) = i*l + j*m + k*n