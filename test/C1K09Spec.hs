{-# LANGUAGE OverloadedStrings #-}
module C1K09Spec
  ( spec
  ) where

import Data.String
import Data.Text (unpack)
import qualified Codec.Binary.UTF8.String as U
import qualified Data.ByteString as B
import Test.Hspec
import Text.Show.Unicode
import C1K09

newtype UString a = UString a deriving Eq

ustring :: B.ByteString -> UString String
ustring = UString . U.decode . B.unpack

instance IsString a => IsString (UString a) where
  fromString = UString . fromString
  
instance Show a => Show (UString a) where
  show (UString s) = ushow s

spec :: Spec
spec = describe "Typoglycemia" $ do
  { it "\"I couldn't believe that I could actually understand what I was reading : the phenomenal power of the human mind .\"の単語の中をシャッフル" $ do
    { typoglycemia message `shouldBe` "I c'dnoult beleive that I cluod alalctuy uretansndd what I was riaedng : the ponenhmael pewor of the hamun mind ."
    }
  }
