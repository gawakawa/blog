module Blog.Types where

import Blog.Data (MediaItem, ReadingStatus, ContentType, Priority)
import Data.Maybe (Maybe)

type State =
  { mediaItems :: Array MediaItem
  , currentView :: View
  , statusFilter :: Maybe ReadingStatus
  , typeFilter :: Maybe ContentType
  , priorityFilter :: Maybe Priority
  , categoryFilter :: Maybe String
  }

data View = HomePage | ItemView Int

data Action
  = Initialize
  | ViewItem Int
  | BackToHome
  | FilterByStatus (Maybe ReadingStatus)
  | FilterByType (Maybe ContentType)
  | FilterByPriority (Maybe Priority)
  | FilterByCategory (Maybe String)