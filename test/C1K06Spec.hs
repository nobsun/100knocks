{-# LANGUAGE OverloadedStrings #-}
module C1K06Spec
  ( spec
  ) where

import Data.String
import Data.Text (unpack)
import qualified Codec.Binary.UTF8.String as U
import qualified Data.ByteString as B
import Test.Hspec
import Text.Show.Unicode
import C1K06

newtype UString a = UString a deriving Eq

ustring :: B.ByteString -> UString String
ustring = UString . U.decode . B.unpack

instance IsString a => IsString (UString a) where
  fromString = UString . fromString
  
instance Show a => Show (UString a) where
  show (UString s) = ushow s

spec :: Spec
spec = describe "集合" $ do
  { it (show paraparaparadise ++ "から文字bi-gramの集合Xを得る") $ do
    { show _X `shouldBe` "fromList [\"ad\",\"ap\",\"ar\",\"di\",\"is\",\"pa\",\"ra\",\"se\"]"
    }
  ; it (show paragraph ++ "から文字bi-gramの集合Yを得る") $ do
    { show _Y `shouldBe` "fromList [\"ag\",\"ap\",\"ar\",\"gr\",\"pa\",\"ph\",\"ra\"]"
    }
  ; it "X ∪ Y" $ do
    { show (_X ∪ _Y) `shouldBe` "fromList [\"ad\",\"ag\",\"ap\",\"ar\",\"di\",\"gr\",\"is\",\"pa\",\"ph\",\"ra\",\"se\"]"
    }
  ; it "X ∩ Y" $ do
    { show (_X ∩ _Y) `shouldBe` "fromList [\"ap\",\"ar\",\"pa\",\"ra\"]"
    }
  ; it "X ／ Y" $ do
    { show (_X ／ _Y) `shouldBe` "fromList [\"ad\",\"di\",\"is\",\"se\"]"
    }
  }
