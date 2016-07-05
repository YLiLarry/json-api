module Network.JSONApi.Document.Success
  ( Success (..)
  ) where

import Data.Aeson (ToJSON, FromJSON, (.=), (.:), (.:?))
import qualified Data.Aeson as AE
import Data.Swagger (ToSchema)
import GHC.Generics
import Network.JSONApi.Link (Links)
import Network.JSONApi.Meta (Meta)
import Network.JSONApi.ResourceObject (ResourceObject)

data Success a b c = Success
  { getData  ::  ResourceObject a b
  , getLinks ::  Maybe Links
  , getMeta  ::  Maybe (Meta c)
  } deriving (Show, Eq, Generic)

instance (ToJSON a, ToJSON b, ToJSON c) => ToJSON (Success a b c) where
  toJSON (Success res links meta) =
    AE.object [ "data"  .= res
              , "links" .= links
              , "meta"  .= meta
              ]

instance (FromJSON a, FromJSON b, FromJSON c) => FromJSON (Success a b c) where
  parseJSON = AE.withObject "success" $ \v ->
    Success
      <$> v .: "data"
      <*> v .:? "links"
      <*> v .:? "meta"

instance (ToSchema a, ToSchema b, ToSchema c) => ToSchema (Success a b c)
