module Blog.Handler where

import Prelude
import Blog.Types (State, View(..), Action(..))
import Effect.Class (class MonadEffect)
import Halogen as H

handleAction :: forall output m. MonadEffect m => Action -> H.HalogenM State Action () output m Unit
handleAction = case _ of
  Initialize -> do
    pure unit
  ViewItem itemId -> do
    H.modify_ _ { currentView = ItemView itemId }
  BackToHome -> do
    H.modify_ _ { currentView = HomePage }
  FilterByStatus status -> do
    H.modify_ _ { statusFilter = status }
  FilterByType contentType -> do
    H.modify_ _ { typeFilter = contentType }
  FilterByPriority priority -> do
    H.modify_ _ { priorityFilter = priority }
  FilterByCategory category -> do
    H.modify_ _ { categoryFilter = category }