{-# LANGUAGE OverloadedStrings #-}
module C1K00 where

import Data.Text (Text)
import qualified Data.Text as T

{- |
   str = "stressed" を逆順にならべた文字列
>>> rev
"desserts"
>>> T.reverse rev == str
True
-}
rev :: Text
rev = T.reverse str

str :: Text
str = "stressed"
