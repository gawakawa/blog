module Blog.Types where

import Blog.Data (MediaItem, ReadingStatus, ContentType, Priority, Category)
import Data.Maybe (Maybe)

type State =
  { mediaItems :: Array MediaItem
  , currentView :: View
  , statusFilter :: Maybe ReadingStatus
  , typeFilter :: Maybe ContentType
  , priorityFilter :: Maybe Priority
  , categoryFilter :: Maybe Category
  }

data View = HomePage | ItemView Int

data Action
  = Initialize
  | ViewItem Int
  | BackToHome
  | FilterByStatus (Maybe ReadingStatus)
  | FilterByType (Maybe ContentType)
  | FilterByPriority (Maybe Priority)
  | FilterByCategory (Maybe Category)