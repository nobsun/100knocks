{-# LANGUAGE OverloadedStrings #-}
module C2K13 where

import Data.List (transpose)
import Data.Text (Text)
import qualified Data.Text as T
import qualified Data.Text.IO as T

{- |
  col1.txtとcol2.tをマージ
>>> paste ["data/col1.txt", "data/col2.txt"]
高知県	江川崎
埼玉県	熊谷
岐阜県	多治見
山形県	山形
山梨県	甲府
和歌山県	かつらぎ
静岡県	天竜
山梨県	勝沼
埼玉県	越谷
群馬県	館林
群馬県	上里見
愛知県	愛西
千葉県	牛久
静岡県	佐久間
愛媛県	宇和島
山形県	酒田
岐阜県	美濃
群馬県	前橋
千葉県	茂原
埼玉県	鳩山
大阪府	豊中
山梨県	大月
山形県	鶴岡
愛知県	名古屋
-}

paste :: [FilePath] -> IO ()
paste fs = (T.unlines . map (T.intercalate "\t") . transpose . map T.lines <$> mapM T.readFile fs) >>= T.putStr
