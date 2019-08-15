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
