module Blog.Utils where

import Prelude
import Blog.Data (MediaItem)
import Data.Array (findMap)
import Data.Maybe (Maybe(..))
import Data.String as String

-- ヘルパー関数
findItem :: Array MediaItem -> Int -> Maybe MediaItem
findItem items id = items # findMap \item -> if item.id == id then Just item else Nothing

truncateContent :: String -> String
truncateContent content =
  if String.length content > 150 then String.take 150 content <> "..."
  else content