{-# LANGUAGE OverloadedStrings #-}
module C1K04 where

import Data.Text (Text)
import qualified Data.Text as T

{- |
   元素記号
>>> :set -XOverloadedStrings
>>> 元素記号
["H","He","Li","Be","B","C","N","O","F","Ne","Na","Mg","Al","Si","P","S","Cl","Ar","K","Ca"]
-}
元素記号 :: [Text]
元素記号 = zipWith takeName [1 ..] $ T.words sentense

sentense :: Text
sentense = "Hi He Lied Because Boron Could Not Oxidize Fluorine. New Nations Might Also Sign Peace Security Clause. Arthur King Can."

takeName :: Int -> Text -> Text
takeName n w = correct (T.take (if n `elem` [1,5,6,7,8,9,15,16,19] then 1 else 2) w)
  where
    correct "Mi" = "Mg"
    correct e    = e
