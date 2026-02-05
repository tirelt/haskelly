import System.Random

data Weapon = Rock | Paper | Scissors
  deriving (Show, Bounded, Enum, Eq)

data Winner = First | Second | Draw
  deriving (Show, Eq, Ord)

winner :: (Weapon, Weapon) -> Winner
winner (Paper, Rock) = First
winner (Scissors, Paper) = First
winner (Rock, Scissors) = First
winner (w1, w2)
  | w1 == w2 = Draw
  | otherwise = Second

instance UniformRange Weapon

uniformRM (lo, hi) rng = do
  res <- uniformRM (fromEnum lo :: Int, fromEnum hi) rng
  pure $ toEnum res

instance Uniform Weapon where
  uniformM rng = uniformRM (minBound, maxBound) rng

randomWeapon :: State StdGen Weapon
randomWeapon = state uniform

gameRound :: State StdGen (Weapon, Weapon)
gameRound = (,) <$> randomWeapon <*> randomWeapon