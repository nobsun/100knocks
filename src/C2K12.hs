{-# LANGUAGE OverloadedStrings #-}
module C2K12 where

import Data.List (transpose)
import Data.Text (Text)
import qualified Data.Text as T
import qualified Data.Text.IO as T

{- |
  1列目をcol1.txtに，2列目をcol2.txtに保存
>>> (tsv <$> T.readFile "data/hightemp.txt") >>= flip saveColumn 1 >> T.readFile "data/col1.txt" >>= T.putStr
高知県
埼玉県
岐阜県
山形県
山梨県
和歌山県
静岡県
山梨県
埼玉県
群馬県
群馬県
愛知県
千葉県
静岡県
愛媛県
山形県
岐阜県
群馬県
千葉県
埼玉県
大阪府
山梨県
山形県
愛知県
>>> (tsv <$> T.readFile "data/hightemp.txt") >>= flip saveColumn 2 >> T.readFile "data/col2.txt" >>= T.putStr
江川崎
熊谷
多治見
山形
甲府
かつらぎ
天竜
勝沼
越谷
館林
上里見
愛西
牛久
佐久間
宇和島
酒田
美濃
前橋
茂原
鳩山
豊中
大月
鶴岡
名古屋
-}

saveColumn :: [[Text]] -> Int -> IO ()
saveColumn tbl n = T.writeFile (col2filepath n "")
                 $ T.unlines
                 $ col n
                 $ cols tbl
               
col2filepath :: Int -> ShowS
col2filepath n = ("data/col" ++) . shows n . (".txt" ++)

cols :: [[Text]] -> [[Text]]
cols = transpose

col :: Int -> [[Text]] -> [Text]
col n = (!! (n-1))

tsv :: Text -> [[Text]]
tsv = map T.words . T.lines
