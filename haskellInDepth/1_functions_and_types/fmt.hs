{-# LANGUAGE OverloadedStrings #-}

import fmt

name = "Theo"
age = 30
test = fmt $ "Hello, "+|name|+"!\nI know that your age is "+|age|+".\n"