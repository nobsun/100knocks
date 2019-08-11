module Main where

import Test.DocTest

main :: IO ()
main = doctest ["src/C1K00.hs"
               ,"src/C1K01.hs"
               ,"src/C1K02.hs"
               ,"src/C1K03.hs"
               ,"src/C1K04.hs"
               ,"src/C1K05.hs"
               ,"src/C1K06.hs"
               ,"src/C1K07.hs"
               ,"src/C1K08.hs"
               ,"src/C1K09.hs"
               ,"src/C2K10.hs"
               ,"src/C2K11.hs"
               ,"src/C2K12.hs"
               ,"src/C2K13.hs"
               ,"src/C2K14.hs"
               ,"src/C2K15.hs"
               ]
