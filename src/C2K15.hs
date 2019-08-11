{-# LANGUAGE OverloadedStrings #-}
module C2K15 where

import Data.Text (Text)
import qualified Data.Text as T
import qualified Data.Text.IO as T
import System.Environment
{- |
  末尾N行を出力
>>> (tails 7 <$> T.readFile "data/hightemp.txt") >>= T.putStr
群馬県	前橋	40	2001-07-24
千葉県	茂原	39.9	2013-08-11
埼玉県	鳩山	39.9	1997-07-05
大阪府	豊中	39.9	1994-08-08
山梨県	大月	39.9	1990-07-19
山形県	鶴岡	39.9	1978-08-03
愛知県	名古屋	39.9	1942-08-02
-}

tails :: Int -> Text -> Text
tails n t = tl ls (drop n ls)
  where
    ls = T.lines t

tl :: [Text] -> [Text] -> Text
tl ts     []     = T.unlines ts
tl (t:ts) (u:us) = tl ts us

tailCmd :: Int -> IO ()
tailCmd n = (tails n <$> T.getContents) >>= T.putStr
