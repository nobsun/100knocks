{-# LANGUAGE OverloadedStrings #-}
module C2K12Spec
  ( spec
  ) where

import Data.String
import System.Process
import qualified Data.Text as T
import qualified Data.Text.IO as T
import qualified Codec.Binary.UTF8.String as U
import qualified Data.ByteString as B
import Test.Main
import Test.Hspec
import Text.Show.Unicode
import C2K12

newtype UString a = UString a deriving Eq

ustring :: B.ByteString -> UString String
ustring = UString . U.decode . B.unpack

instance IsString a => IsString (UString a) where
  fromString = UString . fromString
  
instance Show a => Show (UString a) where
  show (UString s) = ushow s

spec :: Spec
spec = describe "1列目をcol1.txtに，2列目をcol2.txtに保存" $ do
  { it "data/hightemp.txt の1列目をdata/col1.txtに保存" $ do
    { result <- captureProcessResult ((tsv <$> T.readFile "data/hightemp.txt") >>= flip saveColumn 1 >> T.readFile "data/col1.txt" >>= T.putStr)
    ; check  <- captureProcessResult (callCommand "cut -f 1 data/hightemp.txt")
    ; prExitCode result `shouldBe` ExitSuccess
    ; prStderr result `shouldSatisfy` B.null
    ; (prStdout result == prStdout check) `shouldBe` True
    }
  ; it "data/hightemp.txt の2列目をdata/col2.txtに保存" $ do
    { result <- captureProcessResult ((tsv <$> T.readFile "data/hightemp.txt") >>= flip saveColumn 2 >> T.readFile "data/col2.txt" >>= T.putStr)
    ; check  <- captureProcessResult (callCommand "cut -f 2 data/hightemp.txt")
    ; prExitCode result `shouldBe` ExitSuccess
    ; prStderr result `shouldSatisfy` B.null
    ; (prStdout result == prStdout check) `shouldBe` True
    }
  }
