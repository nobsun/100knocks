{-# LANGUAGE OverloadedStrings #-}
module C2K16 where

import Data.Bool
import Data.List (unfoldr)
import System.IO
import System.FilePath
import System.Directory
import Data.Text (Text)
import qualified Data.Text as T
import qualified Data.Text.IO as T
import Text.Printf
{- |
  ファイルをN分割
>>> do { let { f = "data/hightemp.txt"; n = 5 }; ts <- T.lines <$> T.readFile f; splitOutput n ts (splitFiles f n) }
-}

splitOutput ::  Int -> [Text] -> [FilePath] -> IO ()
splitOutput m tts ffs = sequence_ $ zipWith  T.writeFile ffs (map T.unlines (splitEvery n tts))
  where
    n = case length tts `divMod` m of
          (d, 0) -> d
          (d, _) -> succ d

splitEvery :: Int -> [a] -> [[a]]
splitEvery n = unfoldr psi
  where
    psi [] = Nothing
    psi xs = Just $ splitAt n xs

splitFiles :: FilePath -> Int -> [FilePath]
splitFiles f n = map (printf (dir ++ "/%s-%02d" ++ ext) base) $ take n [0::Int ..]
  where
    dir = takeDirectory f
    base = takeBaseName f
    ext  = takeExtension f
