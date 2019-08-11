{-# LANGUAGE OverloadedStrings #-}
module C2K10 where

import System.Process
import Data.Text (Text)
import qualified Data.Text as T
import qualified Data.Text.IO as T

{- |
  行数のカウント
>>> print . lineCount =<< T.readFile "data/hightemp.txt"
24
-}

lineCount :: Text -> Int
lineCount = length . T.lines
