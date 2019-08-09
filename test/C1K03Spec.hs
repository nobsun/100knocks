{-# LANGUAGE OverloadedStrings #-}
module C1K03Spec
  ( spec
  ) where

import Data.String
import qualified Codec.Binary.UTF8.String as U
import qualified Data.ByteString as B
import Test.Hspec
import Text.Show.Unicode
import C1K03

newtype UString a = UString a deriving Eq

ustring :: B.ByteString -> UString String
ustring = UString . U.decode . B.unpack

instance IsString a => IsString (UString a) where
  fromString = UString . fromString
  
instance Show a => Show (UString a) where
  show (UString s) = ushow s

spec :: Spec
spec = describe "円周率" $ do
  { it "\"Now I need a drink, alcoholic of course, after the heavy lectures involving quantum mechanics.\"から円周率へ" $ do
    { 円周率 `shouldBe` [3,1,4,1,5,9,2,6,5,3,5,8,9,7,9]
    }
  }
