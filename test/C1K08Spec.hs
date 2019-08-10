{-# LANGUAGE OverloadedStrings #-}
module C1K08Spec
  ( spec
  ) where

import Data.String
import Data.Text (unpack)
import qualified Codec.Binary.UTF8.String as U
import qualified Data.ByteString as B
import Test.Hspec
import Text.Show.Unicode
import C1K08

newtype UString a = UString a deriving Eq

ustring :: B.ByteString -> UString String
ustring = UString . U.decode . B.unpack

instance IsString a => IsString (UString a) where
  fromString = UString . fromString
  
instance Show a => Show (UString a) where
  show (UString s) = ushow s

spec :: Spec
spec = describe "暗号文" $ do
  { it "\"Imagination is more important than knowledge.\"を暗号化" $ do
    { cipher message `shouldBe` "Inztrmzgrlm rh nliv rnkligzmg gszm pmldovwtv."
    }
  ; it "暗号して復号" $ do
    { cipher (cipher message) == message `shouldBe` True
    }
  }
