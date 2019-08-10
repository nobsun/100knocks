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
パトカー = T.unfoldr psi パタトクカシーー
  where
    psi t = case T.uncons t of
      Nothing     -> Nothing
      Just (c, u) -> Just (c, T.tail u)

パタトクカシーー :: Text
パタトクカシーー = "パタトクカシーー"
