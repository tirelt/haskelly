import System.Random
threeCoins gen = 
    let (firstCoin, newGen) = random gen  
        (secondCoin, newGen') = random newGen  
        (thirdCoin, newGen'') = random newGen'  
    in  (firstCoin, secondCoin, thirdCoin)

manyCoins n = take n $ randoms (mkStdGen 11) :: [Int]

randomRange =randomR (1,6) (mkStdGen 359353) 

randonRanges = take 10 $ randomRs ('a','z') (mkStdGen 3) :: [Char]  
  
main = do  
    gen <- getStdGen  -- create a random random generator
    putStr $ take 20 (randomRs ('a','z') gen)  
    gen' <- newStdGen -- ask for a new random generator, calling again getStdGen gives the same  
    putStr $ take 20 (randomRs ('a','z') gen')  