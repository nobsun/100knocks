{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE DataKinds #-}
module C2K11 where

import Options.Declarative
import qualified GHC.TypeLits as GHC (KnownSymbol)

import Control.Monad.IO.Class
import System.IO

import Data.Maybe (maybe)

import Data.Text (Text)
import qualified Data.Text as T
import qualified Data.Text.IO as T

{- |
  タブをスペースに変換
>>> T.putStr . tab2space =<< T.readFile "data/hightemp.txt"
高知県 江川崎 41 2013-08-12
埼玉県 熊谷 40.9 2007-08-16
岐阜県 多治見 40.9 2007-08-16
山形県 山形 40.8 1933-07-25
山梨県 甲府 40.7 2013-08-10
和歌山県 かつらぎ 40.6 1994-08-08
静岡県 天竜 40.6 1994-08-04
山梨県 勝沼 40.5 2013-08-10
埼玉県 越谷 40.4 2007-08-16
群馬県 館林 40.3 2007-08-16
群馬県 上里見 40.3 1998-07-04
愛知県 愛西 40.3 1994-08-05
千葉県 牛久 40.2 2004-07-20
静岡県 佐久間 40.2 2001-07-24
愛媛県 宇和島 40.2 1927-07-22
山形県 酒田 40.1 1978-08-03
岐阜県 美濃 40 2007-08-16
群馬県 前橋 40 2001-07-24
千葉県 茂原 39.9 2013-08-11
埼玉県 鳩山 39.9 1997-07-05
大阪府 豊中 39.9 1994-08-08
山梨県 大月 39.9 1990-07-19
山形県 鶴岡 39.9 1978-08-03
愛知県 名古屋 39.9 1942-08-02
-}
tab2space :: Text -> Text
tab2space = tr "\t" " "

{- |
  tr コマンド
-}
trCmd :: IO ()
trCmd = run_ $ cmd tr

cmd :: (String -> String -> Text -> Text)
    -> Arg "CHARSET1" String
    -> Arg "CHARSET2" String
    -> Arg "FILEPATH" FilePath
    -> Cmd "Translate characters" ()
cmd c l1 l2 f = liftIO $ case get l1 of
  list1 -> case get l2 of
    list2 -> case get f of {"-" -> T.hGetContents stdin; fp  -> T.readFile fp} >>= print . c list1 list2

tr :: String -> String -> Text -> Text
tr ss ds = T.map conv
  where
    tbl = zip ss ds
    conv c = maybe c id (lookup c tbl)

{-
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE OverloadedStrings #-}
module C2K10 where

import Options.Declarative

import qualified GHC.TypeLits as GHC

import Control.Monad.IO.Class
import System.Environment (getArgs)
import System.IO

import Data.Char (isSpace)
import Data.Text (Text)
import qualified Data.Text as T
import qualified Data.Text.IO as T

{- |
  wc コマンド
-}
wcCmd :: IO ()
wcCmd = run_ $
  Group "print newline, word, and byte counts for file"
  [ subCmd "char" char
  , subCmd "line" line
  , subCmd "word" word
  ]

char :: Arg "FILE" FilePath -> Cmd "Count characters" ()
char = cmd cc

{-|
  文字数カウント
>>> print . cc =<< T.readFile "data/hightemp.txt"
555
-}
cc :: Text -> Int
cc = T.length

line :: Arg "FILE" FilePath -> Cmd "Count lines" ()
line = cmd lc

{- |
  行数カウント
>>> print . lc =<< T.readFile "data/hightemp.txt"
24
-}
lc :: Text -> Int
lc = T.count "\n"


word :: Arg "FILE" FilePath -> Cmd "Count words" ()
word = cmd (wc 0)

{- |
  単語数カウント
>>> print . wc 0 =<< T.readFile "data/hightemp.txt"
96
-}
wc :: Int -> Text -> Int
wc !n t  = case T.dropWhile isSpace t of
  "" -> n
  u  -> wc (n+1) (T.dropWhile (not . isSpace) u)

cmd :: (Show a, GHC.KnownSymbol placefolder, GHC.KnownSymbol help) => (Text -> a) -> Arg placefolder FilePath -> Cmd help ()
cmd c f = liftIO $ case get f of {"-" -> T.hGetContents stdin; fp  -> T.readFile fp} >>= print . c

-}
