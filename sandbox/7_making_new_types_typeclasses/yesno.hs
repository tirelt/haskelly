class YesNo a where  
    yesno :: a -> Bool

instance YesNo Int where  
    yesno 0 = False  
    yesno _ = True  

instance YesNo [a] where  
    yesno [] = False  
    yesno _ = True  

instance YesNo Bool where  
    yesno = id -- identity funtion 

instance YesNo (Maybe a) where  
    yesno (Just _) = True  
    yesno Nothing = False  

yesnoIf yesnoVal yesResult noResult = if yesno yesnoVal then yesResult else noResult 

test1 = yesnoIf [2,3,4] "YEAH!" "NO!"
test2 = yesnoIf Nothing "YEAH!" "NO!" 