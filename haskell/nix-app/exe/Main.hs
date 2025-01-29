{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE DeriveAnyClass    #-}
{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeOperators     #-}

module Main
    where

import           Data.Aeson
import           GHC.Generics
import           Network.Wai.Handler.Warp
import           Servant

type WordsAPI = "words"
             :> ReqBody '[PlainText] String
             :> Post '[JSON] Words

data Words = Words { words :: [String] }
  deriving (Eq, Show, Generic, ToJSON)

server :: Proxy WordsAPI
server = Proxy

handler :: Server WordsAPI
handler text = pure $ Words { Main.words = Prelude.words text }

main :: IO ()
main = runSettings appSettings $ serve server handler
  where appSettings = setPort 8000 $ setHost "0.0.0.0" $ defaultSettings
