module Main
    where

import           MyLib
import           System.IO (BufferMode (NoBuffering), hSetBuffering, stdout)

-- |
--
--
main :: IO ()
main = do
  hSetBuffering stdout NoBuffering
  someFunc
