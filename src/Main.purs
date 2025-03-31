module Main where

import Prelude

import Blog.Components.Footer (footer)
import Blog.Components.Header (header)
import Blog.Data (Post, samplePosts)
import CSS (stylesheet)
import Data.Maybe (Maybe(..))
import Data.String as String
import Data.Array (findMap)
import Effect (Effect)
import Effect.Class (class MonadEffect)
import Effect.Console (log)
import Halogen as H
import Halogen.Aff as HA
import Halogen.HTML as HH
import Halogen.HTML.Events as HE
import Halogen.HTML.Properties as HP
import Halogen.VDom.Driver (runUI)

main :: Effect Unit
main = HA.runHalogenAff do
  body <- HA.awaitBody
  runUI component unit body

type State = 
  { posts :: Array Post
  , currentView :: View
  }

data View = HomePage | PostView Int

data Action 
  = Initialize
  | ViewPost Int
  | BackToHome

initialState :: forall i. i -> State
initialState _ = 
  { posts: samplePosts
  , currentView: HomePage
  }

component :: forall query input output m. MonadEffect m => H.Component query input output m
component =
  H.mkComponent
    { initialState
    , render
    , eval: H.mkEval $ H.defaultEval { handleAction = handleAction }
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
                PostView postId -> renderPostView state postId
            ]
        , footer
        ]
    ]

renderHomePage :: forall m. State -> H.ComponentHTML Action () m
renderHomePage state =
  HH.div
    [ HP.class_ (H.ClassName "posts-list") ]
    (map renderPostPreview state.posts)

renderPostPreview :: forall m. Post -> H.ComponentHTML Action () m
renderPostPreview post =
  HH.div
    [ HP.class_ (H.ClassName "post-preview") ]
    [ HH.h2_ [ HH.text post.title ]
    , HH.p [ HP.class_ (H.ClassName "post-date") ] [ HH.text post.date ]
    , HH.p [ HP.class_ (H.ClassName "post-excerpt") ] [ HH.text (truncateContent post.content) ]
    , HH.button
        [ HP.class_ (H.ClassName "read-more")
        , HE.onClick \_ -> ViewPost post.id
        ]
        [ HH.text "続きを読む" ]
    ]

renderPostView :: forall m. State -> Int -> H.ComponentHTML Action () m
renderPostView state postId =
  case findPost state.posts postId of
    Nothing -> HH.div_ [ HH.text "投稿が見つかりません" ]
    Just post ->
      HH.div
        [ HP.class_ (H.ClassName "post-full") ]
        [ HH.h2_ [ HH.text post.title ]
        , HH.p [ HP.class_ (H.ClassName "post-date") ] [ HH.text post.date ]
        , HH.div 
            [ HP.class_ (H.ClassName "post-content") ] 
            (post.content # String.split (String.Pattern "\n\n") # map \para -> 
              HH.p_ [ HH.text para ])
        , HH.button
            [ HP.class_ (H.ClassName "back-button")
            , HE.onClick \_ -> BackToHome
            ]
            [ HH.text "ホームに戻る" ]
        ]

handleAction :: forall output m. MonadEffect m => Action -> H.HalogenM State Action () output m Unit
handleAction = case _ of
  Initialize -> do
    pure unit
  ViewPost postId -> do
    H.modify_ _ { currentView = PostView postId }
  BackToHome -> do
    H.modify_ _ { currentView = HomePage }

-- ヘルパー関数
findPost :: Array Post -> Int -> Maybe Post
findPost posts id = posts # findMap \post -> if post.id == id then Just post else Nothing

truncateContent :: String -> String
truncateContent content =
  if String.length content > 150
    then String.take 150 content <> "..."
    else content