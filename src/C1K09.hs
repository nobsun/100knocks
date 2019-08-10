{-# LANGUAGE OverloadedStrings #-}
module C1K09 where

import Data.List
import Data.Text (Text)
import qualified Data.Text as T
import System.Random (mkStdGen)
import System.Random.Shuffle (shuffle')

{- |
  Typoglycemia
>>> :set -XOverloadedStrings
>>> message
"I couldn't believe that I could actually understand what I was reading : the phenomenal power of the human mind ."
>>> typoglycemia message
"I c'dnoult beleive that I cluod alalctuy uretansndd what I was riaedng : the ponenhmael pewor of the hamun mind ."
-}

typoglycemia :: Text -> Text
typoglycemia = T.unwords . map (T.pack . portmanteau . T.unpack) . T.words

portmanteau :: String -> String
portmanteau s
  | m <= 4    = s
  | otherwise = c0 : (v' ++ w)
  where
    m = length s
    Just (c0, u) = uncons s
    (v,w)  = splitAt (m-2) u
    v' = shuffle' v (m-2) (mkStdGen 0)

message :: Text
message = "I couldn't believe that I could actually understand what I was reading : the phenomenal power of the human mind ."
