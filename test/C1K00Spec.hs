{-# LANGUAGE OverloadedStrings #-}
module C1K00Spec
  ( spec
  ) where

import Data.String
import qualified Codec.Binary.UTF8.String as U
import qualified Data.ByteString as B
import Test.Hspec
import Text.Show.Unicode
import C1K00

newtype UString a = UString a deriving Eq

ustring :: B.ByteString -> UString String
ustring = UString . U.decode . B.unpack

instance IsString a => IsString (UString a) where
  fromString = UString . fromString
  
instance Show a => Show (UString a) where
  show (UString s) = ushow s

spec :: Spec
spec = describe "desserts" $ do
  { it "\"stressed\"を逆から並べた文字列" $ do
    { desserts `shouldBe` "desserts"
    }
  }
