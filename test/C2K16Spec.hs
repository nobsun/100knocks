{-# LANGUAGE OverloadedStrings #-}
module C2K16Spec
  ( spec
  ) where

import Data.List (intercalate)
import Data.String
import System.Process
import qualified Data.Text as T
import qualified Data.Text.IO as T
import qualified Codec.Binary.UTF8.String as U
import qualified Data.ByteString as B
import Test.Main
import Test.Hspec
import Text.Show.Unicode
import Text.Printf
import C2K16

newtype UString a = UString a deriving Eq

ustring :: B.ByteString -> UString String
ustring = UString . U.decode . B.unpack

instance IsString a => IsString (UString a) where
  fromString = UString . fromString
  
instance Show a => Show (UString a) where
  show (UString s) = ushow s

spec :: Spec
spec = describe "ファイルをN分割" $ do
  { it "data/hightemp.txt を5分割" $ do
    { let { f = "data/hightemp.txt"; n = 5 }
    ; result <- captureProcessResult $ do { let { f = "data/hightemp.txt"; n = 5 }; ts <- T.lines <$> T.readFile f; splitOutput n ts (splitFiles f n) }
    ; check  <- captureProcessResult $ do { sz <- chunkSize n f
                                          ; callCommand ("split -l " ++ show sz ++ " -d "  ++ f ++ " " ++ show "data/chunk-")
                                          }
    ; prExitCode result `shouldBe` ExitSuccess
    ; prStderr result `shouldSatisfy` B.null
    }
  ; loop diffs
  }

chunkSize :: Int -> FilePath -> IO Int
chunkSize n f = do
  { m <- length . T.lines <$> T.readFile f
  ; return $ case m `divMod` n of
               (d, 0) -> d
               (d, _) -> succ d
  }

loop :: [String] -> Spec
loop []     = return ()
loop (c:cs) = (it c $ do
  { result <- captureProcessResult (callCommand c)
  -- ; prExitCode result `shouldBe` ExitSuccess
  ; prStderr result `shouldSatisfy` B.null
  ; prStdout result `shouldSatisfy` B.null 
  }) >> loop cs

chunks :: [FilePath]
chunks = map (printf "data/chunk-%02d") $ take 5 [(0::Int) ..]

diffs :: [String]
diffs = zipWith diff chunks (splitFiles "data/hightemp.txt" 5)
  where
    diff f f' = intercalate " " ["diff", f, f']
