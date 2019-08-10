{-# LANGUAGE OverloadedStrings #-}
module C1K00 where

import Data.Text (Text)
import qualified Data.Text as T

{- |
   stressed = "stressed" を逆順にならべた文字列
>>> desserts
"desserts"
>>> T.reverse desserts == stressed
True
-}
desserts :: Text
desserts = T.reverse stressed

stressed :: Text
stressed = "stressed"
