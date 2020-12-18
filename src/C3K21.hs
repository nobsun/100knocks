{-# LANGUAGE OverloadedStrings #-}
module C3K21 where

import C3K20 (sampleText)

import qualified Data.Text as T
import qualified Data.Text.Lazy.IO as T
import qualified Data.Text.Lazy.Encoding as T

import Text.Show.Unicode (uprint)

categories :: IO [T.Text]
categories = filter (T.isInfixOf "Category:") . T.lines <$> sampleText

c3k21 :: IO ()
c3k21 = mapM_ uprint =<< categories