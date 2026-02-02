import qualified Data.Text as T
data Expr a = Lit a
    | Add (Expr a) (Expr a)
    | Mult (Expr a) (Expr a)

myeval :: Num a => Expr a -> a
myeval (Lit e) = e
myeval (Add e1 e2) = myeval e1 + myeval e2
myeval (Mult e1 e2) = myeval e1 * myeval e2

expr1 = Mult (Add (Lit 2) (Mult (Lit 3) (Lit 3))) (Lit 5)

test = myeval expr1 -- 55

instance TextShow a => TextShow (Expr a) where
  showbPrec p e =
    case e of
      Lit a -> showb a
      Add e1 e2 -> showbHelper p 5 "+" e1 e2
      Mult e1 e2 -> showbHelper p 6 "*" e1 e2
    where
      showbHelper outerPrec thisPrec op e1 e2 =
        showbParen (outerPrec > thisPrec)
        $ showbPrec thisPrec e1 <> op <> showbPrec thisPrec e2
