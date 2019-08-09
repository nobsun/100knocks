{-# LANGUAGE OverloadedStrings #-}
module C1K01Spec
  ( spec
  ) where

import Data.String
import qualified Codec.Binary.UTF8.String as U
import qualified Data.ByteString as B
import Test.Hspec
import Text.Show.Unicode
import C1K01

newtype UString a = UString a deriving Eq

ustring :: B.ByteString -> UString String
ustring = UString . U.decode . B.unpack

instance IsString a => IsString (UString a) where
  fromString = UString . fromString
  
instance Show a => Show (UString a) where
  show (UString s) = ushow s

spec :: Spec
spec = describe "パトカー" $ do
  { it "\"パタトクカシーー\"の1,3,5,7文字目を取り出して連結した文字列" $ do
    { パトカー `shouldBe` "パトカー"
    }
  }
