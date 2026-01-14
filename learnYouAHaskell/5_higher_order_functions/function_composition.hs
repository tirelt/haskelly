nice = map (negate . abs) [5,-3,-6,7,-3,2,-19,24]  

notPretty = replicate 100 (product (map (*3) (zipWith max [1,2,3,4,5] [4,5,6,7,8])))
veryPretty = replicate 100 . product . map (*3) . zipWith max [1,2,3,4,5] $ [4,5,6,7,8]