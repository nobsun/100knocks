{-# LANGUAGE OverloadedStrings #-}
module C1K02 where

import Data.Text (Text)
import qualified Data.Text as T

{- |
   パタトクカシーー
>>> :set -XOverloadedStrings
>>> パタトクカシーー == "パタトクカシーー"
True
-}
パタトクカシーー :: Text
パタトクカシーー = interleave パトカー タクシー

interleave :: Text -> Text -> Text
interleave t u = T.unfoldr psi (t, u)
  where
    psi (p, q)  = case T.uncons p of
      Nothing     -> Nothing
      Just (c, v) -> Just (c, (q, v))

パトカー :: Text
パトカー = "パトカー"

タクシー :: Text
タクシー = "タクシー"
