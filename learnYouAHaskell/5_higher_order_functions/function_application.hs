-- to avoid writing sum (filter (> 10) (map (*2) [2..10]))
-- ($) has the lowest precedence
test = sum $ filter (> 10) $ map (*2) [2..10]

nice = sqrt $ 3 + 4 + 9

veryCool = map ($ 3) [(+4), (10*), (^2), sqrt]  