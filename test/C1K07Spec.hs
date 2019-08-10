{-# LANGUAGE OverloadedStrings #-}
module C1K07Spec
  ( spec
  ) where

import Data.String
import Data.Text (unpack)
import qualified Codec.Binary.UTF8.String as U
import qualified Data.ByteString as B
import Test.Hspec
import Text.Show.Unicode
import C1K07

newtype UString a = UString a deriving Eq

ustring :: B.ByteString -> UString String
ustring = UString . U.decode . B.unpack

instance IsString a => IsString (UString a) where
  fromString = UString . fromString
  
instance Show a => Show (UString a) where
  show (UString s) = ushow s

spec :: Spec
spec = describe "テンプレートによる文生成" $ do
  { it "sentense 12 \"気温\" 22.4で生成される文" $ do
    { sentense 12 "気温" 22.4 `shouldBe` "12時の気温は22.4"
    }
  }
