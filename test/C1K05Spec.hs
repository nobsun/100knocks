{-# LANGUAGE OverloadedStrings #-}
module C1K05Spec
  ( spec
  ) where

import Data.String
import Data.Text (unpack)
import qualified Codec.Binary.UTF8.String as U
import qualified Data.ByteString as B
import Test.Hspec
import Text.Show.Unicode
import C1K05

newtype UString a = UString a deriving Eq

ustring :: B.ByteString -> UString String
ustring = UString . U.decode . B.unpack

instance IsString a => IsString (UString a) where
  fromString = UString . fromString
  
instance Show a => Show (UString a) where
  show (UString s) = ushow s

spec :: Spec
spec = describe "n-gram" $ do
  { it (show sentense ++ "から単語bi-gramを得る") $ do
    { 単語bigram `shouldBe` [["I","am"],["am","an"],["an","NLPer"]]
    }
  ; it (show sentense ++ "から文字bi-gramを得る") $ do
    { 文字bigram `shouldBe` ["I "," a","am","m "," a","an","n "," N","NL","LP","Pe","er"]
    }
  }
