{-# LANGUAGE OverloadedStrings #-}
module C1K07 where

import Text.Printf (printf)
import Data.Text (Text)
import qualified Data.Text as T

{- |
  テンプレートによる文生成
>>> :set -XOverloadedStrings
>>> :set -interactive-print=Text.Show.Unicode.uprint
>>> sentense 12 "気温" 22.4
"12時の気温は22.4"
-}

sentense :: Int -> Text -> Float -> Text
sentense x y z = T.pack $ printf template x y z

template :: String
template = "%d時の%sは%f"

