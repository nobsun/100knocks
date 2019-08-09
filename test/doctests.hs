module Main where

import Test.DocTest

main :: IO ()
main = doctest ["src/C1K00.hs"
               ,"src/C1K01.hs"
               ,"src/C1K02.hs"
               ,"src/C1K03.hs"
               ]
