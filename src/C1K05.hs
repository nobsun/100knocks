{-# LANGUAGE OverloadedStrings #-}
module C1K05 where

import Data.List
import Data.Text (Text)
import qualified Data.Text as T

{- |
   n-gram
>>> :set -XOverloadedStrings
>>> 単語bigram
[["I","am"],["am","an"],["an","NLPer"]]
>>> 文字bigram
["I "," a","am","m "," a","an","n "," N","NL","LP","Pe","er"]
-}
単語bigram :: [[Text]]
単語bigram = nGram 2 (T.words sentense)

文字bigram :: [Text]
文字bigram = 文字nGram 2 sentense

文字nGram :: Int -> Text -> [Text]
文字nGram n = (!! n) . transpose . map T.inits . T.tails

nGram :: Int -> [a] -> [[a]]
nGram n = (!! n) . transpose . map inits . tails

sentense :: Text
sentense = "I am an NLPer"
