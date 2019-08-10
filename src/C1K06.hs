{-# LANGUAGE OverloadedStrings #-}
module C1K06 where

import qualified Data.List as L
import Data.Set (Set)
import qualified Data.Set as S
import Data.Text (Text)
import qualified Data.Text as T

{- |
  集合
>>> :set -XOverloadedStrings
>>> _X
fromList ["ad","ap","ar","di","is","pa","ra","se"]
>>> _Y
fromList ["ag","ap","ar","gr","pa","ph","ra"]
>>> _X ∪ _Y
fromList ["ad","ag","ap","ar","di","gr","is","pa","ph","ra","se"]
>>> _X ∩ _Y
fromList ["ap","ar","pa","ra"]
>>> _X ／ _Y
fromList ["ad","di","is","se"]
-}

_X :: Set Text
_X = S.fromList (文字nGram 2 paraparaparadise)

_Y :: Set Text
_Y = S.fromList (文字nGram 2 paragraph)

(∪) :: Ord a => Set a -> Set a -> Set a
(∪) = S.union
(∩) :: Ord a => Set a -> Set a -> Set a
(∩) = S.intersection
(／) :: Ord a => Set a -> Set a -> Set a
(／) = S.difference

文字nGram :: Int -> Text -> [Text]
文字nGram n = (!! n) . L.transpose . L.map T.inits . T.tails

paraparaparadise :: Text
paraparaparadise = "paraparaparadise"

paragraph :: Text
paragraph = "paragraph"
