{-# LANGUAGE OverloadedStrings #-}
module C2K15Spec
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
import C2K15

newtype UString a = UString a deriving Eq

ustring :: B.ByteString -> UString String
ustring = UString . U.decode . B.unpack

instance IsString a => IsString (UString a) where
  fromString = UString . fromString
  
instance Show a => Show (UString a) where
  show (UString s) = ushow s

spec :: Spec
spec = describe "末尾N行を出力" $ do
  { it "末尾N行を出力" $ do
    { result <- captureProcessResult ((tails 7 <$> T.readFile "data/hightemp.txt") >>= T.putStr)
    ; check  <- captureProcessResult (callCommand "tail -n 7 data/hightemp.txt")
    ; prExitCode result `shouldBe` ExitSuccess
    ; prStderr result `shouldSatisfy` B.null
    ; (prStdout result == prStdout check) `shouldBe` True
    }
  }
