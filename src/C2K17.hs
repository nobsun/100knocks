{-# LANGUAGE OverloadedStrings #-}
module C2K17 where

import Data.List (sort)
import Data.Set (Set)
import qualified Data.Set as S
import Data.Text (Text)
import qualified Data.Text as T
import qualified Data.Text.IO as T
{- |
  n列目の文字列の異なり
>>> T.putStr . T.unlines . S.toList . textSet 1 =<< T.readFile "data/hightemp.txt"
千葉県
和歌山県
埼玉県
大阪府
山形県
山梨県
岐阜県
愛媛県
愛知県
群馬県
静岡県
高知県
-}

textSet :: Int -> Text -> Set Text
textSet n = S.fromList . map ((!! pred n) . T.words) . T.lines
