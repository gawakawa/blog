module Blog.Component where

import Prelude
import Blog.Data (sampleMediaItems)
import Blog.Types (State, View(..), Action)
import Blog.Pages.Home (renderHomePage)
import Blog.Pages.ItemView (renderItemView)
import Blog.Handler (handleAction)
import Blog.Components.Footer (footer)
import Blog.Components.Header (header)
import CSS (stylesheet)
import Data.Maybe (Maybe(..))
import Effect.Class (class MonadEffect)
import Halogen as H
import Halogen.HTML as HH
import Halogen.HTML.Properties as HP

initialState :: forall i. i -> State
initialState _ =
  { mediaItems: sampleMediaItems
  , currentView: HomePage
  , statusFilter: Nothing
  , typeFilter: Nothing
  , priorityFilter: Nothing
  , categoryFilter: Nothing
  }

render :: forall m. State -> H.ComponentHTML Action () m
render state =
  HH.div_
    [ stylesheet
    , HH.div
        [ HP.class_ (H.ClassName "blog-container") ]
        [ header
        , HH.main_
            [ case state.currentView of
                HomePage -> renderHomePage state
                ItemView itemId -> renderItemView state itemId
            ]
        , footer
        ]
    ]

component :: forall query input output m. MonadEffect m => H.Component query input output m
component =
  H.mkComponent
    { initialState
    , render
    , eval: H.mkEval $ H.defaultEval { handleAction = handleAction }
    }