{-# LANGUAGE OverloadedStrings #-}
module C2K10Spec
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
import C2K10

newtype UString a = UString a deriving Eq

ustring :: B.ByteString -> UString String
ustring = UString . U.decode . B.unpack

instance IsString a => IsString (UString a) where
  fromString = UString . fromString
  
instance Show a => Show (UString a) where
  show (UString s) = ushow s

spec :: Spec
spec = describe "行数のカウント" $ do
  { it "data/hightemp.txt の行数をカウント" $ do
    { result <- captureProcessResult (print . lineCount =<< T.readFile "data/hightemp.txt")
    ; check  <- captureProcessResult (callCommand "wc -l < data/hightemp.txt")
    ; prExitCode result `shouldBe` ExitSuccess
    ; prStderr result `shouldSatisfy` B.null
    ; (prStdout result == prStdout check) `shouldBe` True
    }
  }
