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
interleave "" "" = ""
interleave tts uus = t `T.append` u `T.append` interleave ts us
  where
    (t, ts) = T.splitAt 1 tts
    (u, us) = T.splitAt 1 uus

パトカー :: Text
パトカー = "パトカー"

タクシー :: Text
タクシー = "タクシー"

