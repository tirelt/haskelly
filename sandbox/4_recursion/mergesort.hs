split [] = ([],[])
split [x] = ([x],[])
split (a:b:xs) = let (l,q) = split xs in (a:l,b:q)

merge xa [] = xa
merge [] xb = xb
merge xa@(a:qa) xb@(b:qb) 
    | a <= b = a : merge qa xb
    | otherwise = b : merge xa qb

mergesort [] = []
mergesort [x] = [x]
mergesort xs = let (xs_1,xs_2) = split xs in merge (mergesort xs_1) (mergesort xs_2) 