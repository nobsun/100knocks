{-# LANGUAGE OverloadedStrings #-}
module C1K02Spec
  ( spec
  ) where

import Data.String
import qualified Codec.Binary.UTF8.String as U
import qualified Data.ByteString as B
import Test.Hspec
import Text.Show.Unicode
import C1K02

newtype UString a = UString a deriving Eq

ustring :: B.ByteString -> UString String
ustring = UString . U.decode . B.unpack

instance IsString a => IsString (UString a) where
  fromString = UString . fromString
  
instance Show a => Show (UString a) where
  show (UString s) = ushow s

spec :: Spec
spec = describe "パタトクカシーー" $ do
  { it "\"パトカー\"と\"タクシー\"の文字を先頭から交互に連結しタ文字列" $ do
    { パタトクカシーー `shouldBe` "パタトクカシーー"
    }
  }
