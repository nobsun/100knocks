{-# LANGUAGE OverloadedStrings #-}
module C1K03 where

import Data.Char (isAlpha)
import Data.List (unfoldr)
import Data.Text (Text)
import qualified Data.Text as T

{- |
   円周率
>>> :set -XOverloadedStrings
>>> 円周率
[3,1,4,1,5,9,2,6,5,3,5,8,9,7,9]
-}

円周率 :: [Int]
円周率 = unfoldr psi sentense
  where
    psi t = case T.dropWhile (not . isAlpha) t of
      "" -> Nothing
      u  -> case T.span isAlpha u of
        (v, w) -> Just (T.length v, w)

sentense :: Text
sentense = "Now I need a drink, alcoholic of course, after the heavy lectures involving quantum mechanics."
