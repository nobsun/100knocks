{-# LANGUAGE OverloadedStrings #-}
module C1K01 where

import Data.Text (Text)
import qualified Data.Text as T

{- |
   パトカー
>>> :set -XOverloadedStrings
>>> パトカー == "パトカー"
True
-}
パトカー :: Text
パトカー = takeAtOdd パタトクカシーー

takeAtOdd :: Text -> Text
takeAtOdd "" = ""
takeAtOdd ts = T.take 1 ts `T.append` dropAtEven (T.drop 1 ts)

dropAtEven :: Text -> Text
dropAtEven "" = ""
dropAtEven ts = takeAtOdd (T.drop 1 ts)

パタトクカシーー :: Text
パタトクカシーー = "パタトクカシーー"
