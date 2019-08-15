{-# LANGUAGE OverloadedStrings #-}
module C2K19 where

import Data.Bool (bool)
import Data.List (sortBy, sort, groupBy, group)
import Data.Ord (comparing)
import Data.Set (Set)
import qualified Data.Set as S
import Data.Text (Text)
import qualified Data.Text as T
import qualified Data.Text.IO as T
{- |
  各行の1カラム目の文字列の出現頻度を求め，出現頻度の高い順に並べる
>>> T.putStr . T.unlines . map snd . sortByFreq . map (head . T.words) . T.lines =<< T.readFile "data/hightemp.txt"
群馬県
山梨県
山形県
埼玉県
静岡県
愛知県
岐阜県
千葉県
高知県
愛媛県
大阪府
和歌山県
-}

sortByFreq :: [Text] -> [(Int, Text)]
sortByFreq = sortBy (flip compare) . map ((,) . length <*> head) . group . sort
