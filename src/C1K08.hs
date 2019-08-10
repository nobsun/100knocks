{-# LANGUAGE OverloadedStrings #-}
module C1K08 where

import Data.Bool (bool)
import Data.Char (isLower, isAscii, ord, chr)
import Data.Text (Text)
import qualified Data.Text as T

{- |
  暗号文
>>> :set -XOverloadedStrings
>>> message
"Imagination is more important than knowledge."
>>> cipher message
"Inztrmzgrlm rh nliv rnkligzmg gszm pmldovwtv."
>>> cipher (cipher message) == message
True
-}

cipher :: Text -> Text
cipher = T.map enc

enc :: Char -> Char
enc c = bool c (chr (219 - ord c)) (isLower c && isAscii c)

message :: Text
message = "Imagination is more important than knowledge."
