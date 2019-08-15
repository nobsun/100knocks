{-# LANGUAGE OverloadedStrings #-}
module C2K19Spec
  ( spec
  ) where

import Data.Ord (comparing)
import Data.List (intercalate)
import Data.String
import System.Process
import Data.Set (Set)
import qualified Data.Set as S
import qualified Data.Text as T
import qualified Data.Text.IO as T
import qualified Codec.Binary.UTF8.String as U
import qualified Data.ByteString as B
import Test.Main
import Test.Hspec
import Text.Show.Unicode
import Text.Printf
import C2K19

newtype UString a = UString a deriving Eq

ustring :: B.ByteString -> UString String
ustring = UString . U.decode . B.unpack

instance IsString a => IsString (UString a) where
  fromString = UString . fromString
  
instance Show a => Show (UString a) where
  show (UString s) = ushow s

spec :: Spec
spec = describe "各行の1カラム目の文字列の出現頻度の高いもの順に並べる" $ do
  { it "data/hightemp.txt の1カラム目．出現頻度順" $ do
    { let { f = "data/hightemp.txt"}
    ; result <- captureProcessResult $ T.putStr . T.unlines . map snd . sortByFreq . map (head . T.words) . T.lines =<< T.readFile f
    ; check  <- captureProcessResult $ callCommand $ "cut -f 1 " ++ f ++ " | sort | uniq -c | LANG=C sort -r | cut -b 9-"
    ; prExitCode result `shouldBe` ExitSuccess
    ; prStderr result `shouldSatisfy` B.null
    ; prExitCode check `shouldBe` ExitSuccess
    ; prStderr check `shouldSatisfy` B.null
    ; ustring (prStdout result) `shouldBe` ustring (prStdout check)
    }
  }
