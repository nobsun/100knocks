{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}
module C3K20
  where

import qualified Data.ByteString.Lazy as B
import qualified Data.ByteString.Lazy.UTF8 as B

import qualified Data.Text as T
import qualified Data.Text.Lazy.IO as T
import qualified Data.Text.Lazy.Encoding as T

import Text.Show.Unicode (uprint)

-- import qualified Data.Vector as V
-- import qualified Data.HashMap.Strict as HM

-- import Data.ByteString
import Data.Aeson ( decode, FromJSON, ToJSON, Array)
import GHC.Generics ( Generic )
import Data.Text ( Text )
import Data.Maybe ( fromMaybe )

data Article = Article
  { title :: Text
  , text  :: Text
  } deriving (Show, Generic)

instance FromJSON Article
instance ToJSON Article

articles :: IO [Article]
articles = Prelude.map toArticle . B.lines <$> B.readFile "data/jawiki-country.json"

toArticle :: B.ByteString -> Article
toArticle s = fromMaybe (error "no parse") (decode s)

sampleText :: IO Text
sampleText = text . head . filter (("イギリス" ==) . title) <$> articles

c3k20 :: IO ()
c3k20 = uprint =<< sampleText