{-# LANGUAGE OverloadedStrings #-}
module C1K03 where

import Data.Char
import Data.Text (Text)
import qualified Data.Text as T

{- |
   円周率
>>> :set -XOverloadedStrings
>>> 円周率
[3,1,4,1,5,9,2,6,5,3,5,8,9,7,9]
-}

円周率 :: [Int]
円周率 = map (T.length . T.filter isAlpha) $ T.words sentense

sentense :: Text
sentense = "Now I need a drink, alcoholic of course, after the heavy lectures involving quantum mechanics."
