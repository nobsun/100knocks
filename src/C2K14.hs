{-# LANGUAGE OverloadedStrings #-}
module C2K14 where

import Data.Text (Text)
import qualified Data.Text as T
import qualified Data.Text.IO as T
import System.Environment
{- |
  先頭からN行を出力
>>> (heads 7 <$> T.readFile "data/hightemp.txt") >>= T.putStr
高知県	江川崎	41	2013-08-12
埼玉県	熊谷	40.9	2007-08-16
岐阜県	多治見	40.9	2007-08-16
山形県	山形	40.8	1933-07-25
山梨県	甲府	40.7	2013-08-10
和歌山県	かつらぎ	40.6	1994-08-08
静岡県	天竜	40.6	1994-08-04
-}

heads :: Int -> Text -> Text
heads n = T.unlines . take n . T.lines

headCmd :: Int -> IO ()
headCmd n = (heads n <$> T.getContents) >>= T.putStr
