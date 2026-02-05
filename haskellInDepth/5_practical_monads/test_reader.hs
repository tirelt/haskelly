import Control.Monad.Reader

calculateContentLen :: Reader String String
calculateContentLen = do
  content <- ask
  return content

-- Calls calculateContentLen after adding a prefix to the Reader content.
calculateModifiedContentLen :: Reader String String
calculateModifiedContentLen = local ("Prefix " ++) calculateContentLen

main :: IO ()
main = do
  let s = "12345"
  let modifiedLen = runReader calculateModifiedContentLen s
  let len = runReader calculateContentLen s
  putStrLn $ "Modified 's' length: " ++ modifiedLen
  putStrLn $ "Original 's' length: " ++ len