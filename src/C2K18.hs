{-# LANGUAGE OverloadedStrings #-}
module C2K18 where

import Control.Arrow ((&&&))
import Data.List (sortBy)
import Data.Ord (comparing)
import Data.Set (Set)
import qualified Data.Set as S
import Data.Text (Text)
import qualified Data.Text as T
import qualified Data.Text.IO as T
{- |
  各行を3コラム目の数値の降順にソート
>>> T.putStr . T.unlines . reverse . sortRecords (comparing temp) . T.lines =<< T.readFile "data/hightemp.txt"
高知県	江川崎	41	2013-08-12
岐阜県	多治見	40.9	2007-08-16
埼玉県	熊谷	40.9	2007-08-16
山形県	山形	40.8	1933-07-25
山梨県	甲府	40.7	2013-08-10
静岡県	天竜	40.6	1994-08-04
和歌山県	かつらぎ	40.6	1994-08-08
山梨県	勝沼	40.5	2013-08-10
埼玉県	越谷	40.4	2007-08-16
群馬県	館林	40.3	2007-08-16
群馬県	上里見	40.3	1998-07-04
愛知県	愛西	40.3	1994-08-05
静岡県	佐久間	40.2	2001-07-24
愛媛県	宇和島	40.2	1927-07-22
千葉県	牛久	40.2	2004-07-20
山形県	酒田	40.1	1978-08-03
群馬県	前橋	40	2001-07-24
岐阜県	美濃	40	2007-08-16
愛知県	名古屋	39.9	1942-08-02
山梨県	大月	39.9	1990-07-19
山形県	鶴岡	39.9	1978-08-03
大阪府	豊中	39.9	1994-08-08
埼玉県	鳩山	39.9	1997-07-05
千葉県	茂原	39.9	2013-08-11
-}

temp :: Text -> (Float, Text)
temp = read . T.unpack . (!! 2) . T.words &&& id

sortRecords :: (Text -> Text -> Ordering) -> [Text] -> [Text]
sortRecords = sortBy