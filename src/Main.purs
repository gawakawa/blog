module Main where

import Prelude

import Blog.Components.Footer (footer)
import Blog.Components.Header (header)
import Blog.Data (MediaItem, ContentType(..), ReadingStatus(..), Priority(..), sampleMediaItems)
import CSS (stylesheet)
import Data.Maybe (Maybe(..), fromMaybe)
import Data.String as String
import Data.Array (findMap, sortBy, filter, any, nub, sort, fold)
import Data.Ord (comparing)
import Effect (Effect)
import Effect.Class (class MonadEffect)
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

initialState :: forall i. i -> State
initialState _ =
  { mediaItems: sampleMediaItems
  , currentView: HomePage
  , statusFilter: Nothing
  , typeFilter: Nothing
  , priorityFilter: Nothing
  , categoryFilter: Nothing
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
                ItemView itemId -> renderItemView state itemId
            ]
        , footer
        ]
    ]

renderHomePage :: forall m. State -> H.ComponentHTML Action () m
renderHomePage state =
  HH.div
    [ HP.class_ (H.ClassName "home-content") ]
    [ HH.div
        [ HP.class_ (H.ClassName "yearly-goals") ]
        [ HH.h3_ [ HH.text "2025 年度の目標" ]
        , HH.div [ HP.class_ (H.ClassName "goal-main") ]
            [ HH.h4_ [ HH.text "達成感を得る" ]
            , HH.div [ HP.class_ (H.ClassName "goal-medium") ]
                [ HH.h5_ [ HH.text "本、論文を読む" ]
                , HH.div [ HP.class_ (H.ClassName "checkbox-container") ]
                    [ HH.input
                        [ HP.type_ HP.InputCheckbox
                        , HP.id "goal-1-1"
                        , HP.class_ (H.ClassName "goal-checkbox")
                        ]
                    , HH.label
                        [ HP.class_ (H.ClassName "checkbox-label")
                        , HP.for "goal-1-1"
                        ]
                        [ HH.text "週に 1 度は必ず本を読む" ]
                    ]
                , HH.div [ HP.class_ (H.ClassName "checkbox-container") ]
                    [ HH.input
                        [ HP.type_ HP.InputCheckbox
                        , HP.id "goal-1-2"
                        , HP.class_ (H.ClassName "goal-checkbox")
                        ]
                    , HH.label
                        [ HP.class_ (H.ClassName "checkbox-label")
                        , HP.for "goal-1-2"
                        ]
                        [ HH.text "月に 1 本は論文を読む" ]
                    ]
                ]
            , HH.div [ HP.class_ (H.ClassName "goal-medium") ]
                [ HH.h5_ [ HH.text "自作する" ]
                , HH.div [ HP.class_ (H.ClassName "checkbox-container") ]
                    [ HH.input
                        [ HP.type_ HP.InputCheckbox
                        , HP.id "goal-2-1"
                        , HP.class_ (H.ClassName "goal-checkbox")
                        ]
                    , HH.label
                        [ HP.class_ (H.ClassName "checkbox-label")
                        , HP.for "goal-2-1"
                        ]
                        [ HH.text "OS" ]
                    ]
                , HH.div [ HP.class_ (H.ClassName "checkbox-container") ]
                    [ HH.input
                        [ HP.type_ HP.InputCheckbox
                        , HP.id "goal-2-2"
                        , HP.class_ (H.ClassName "goal-checkbox")
                        ]
                    , HH.label
                        [ HP.class_ (H.ClassName "checkbox-label")
                        , HP.for "goal-2-2"
                        ]
                        [ HH.text "ネットワーク" ]
                    ]
                , HH.div [ HP.class_ (H.ClassName "checkbox-container") ]
                    [ HH.input
                        [ HP.type_ HP.InputCheckbox
                        , HP.id "goal-2-3"
                        , HP.class_ (H.ClassName "goal-checkbox")
                        ]
                    , HH.label
                        [ HP.class_ (H.ClassName "checkbox-label")
                        , HP.for "goal-2-3"
                        ]
                        [ HH.text "ブラウザ" ]
                    ]
                , HH.div [ HP.class_ (H.ClassName "checkbox-container") ]
                    [ HH.input
                        [ HP.type_ HP.InputCheckbox
                        , HP.id "goal-2-4"
                        , HP.class_ (H.ClassName "goal-checkbox")
                        ]
                    , HH.label
                        [ HP.class_ (H.ClassName "checkbox-label")
                        , HP.for "goal-2-4"
                        ]
                        [ HH.text "Promise" ]
                    ]
                ]
            , HH.div [ HP.class_ (H.ClassName "goal-medium") ]
                [ HH.h5_ [ HH.text "資格を取る" ]
                , HH.div [ HP.class_ (H.ClassName "checkbox-container") ]
                    [ HH.input
                        [ HP.type_ HP.InputCheckbox
                        , HP.id "goal-3-1"
                        , HP.class_ (H.ClassName "goal-checkbox")
                        ]
                    , HH.label
                        [ HP.class_ (H.ClassName "checkbox-label")
                        , HP.for "goal-3-1"
                        ]
                        [ HH.text "応用情報、DB スペシャリスト" ]
                    ]
                , HH.div [ HP.class_ (H.ClassName "checkbox-container") ]
                    [ HH.input
                        [ HP.type_ HP.InputCheckbox
                        , HP.id "goal-3-2"
                        , HP.class_ (H.ClassName "goal-checkbox")
                        ]
                    , HH.label
                        [ HP.class_ (H.ClassName "checkbox-label")
                        , HP.for "goal-3-2"
                        ]
                        [ HH.text "Google Cloud Architect" ]
                    ]
                , HH.div [ HP.class_ (H.ClassName "checkbox-container") ]
                    [ HH.input
                        [ HP.type_ HP.InputCheckbox
                        , HP.id "goal-3-3"
                        , HP.class_ (H.ClassName "goal-checkbox")
                        ]
                    , HH.label
                        [ HP.class_ (H.ClassName "checkbox-label")
                        , HP.for "goal-3-3"
                        ]
                        [ HH.text "TOEFL 80 点以上" ]
                    ]
                ]
            ]
        ]
    , renderFilters state
    , HH.div
        [ HP.class_ (H.ClassName "media-list") ]
        (map renderMediaCard (filterMediaItems state))
    ]

renderFilters :: forall m. State -> H.ComponentHTML Action () m
renderFilters state =
  HH.div
    [ HP.class_ (H.ClassName "filters") ]
    [ HH.div
        [ HP.class_ (H.ClassName "filter-group") ]
        [ HH.label
            [ HP.class_ (H.ClassName "filter-label") ]
            [ HH.text "コンテンツの種類：" ]
        , renderFilterButton (state.typeFilter == Just Book) (FilterByType (Just Book)) "本"
        , renderFilterButton (state.typeFilter == Just Article) (FilterByType (Just Article)) "記事"
        , renderFilterButton (state.typeFilter == Nothing) (FilterByType Nothing) "すべて"
        ]
    , HH.div
        [ HP.class_ (H.ClassName "filter-group") ]
        [ HH.label
            [ HP.class_ (H.ClassName "filter-label") ]
            [ HH.text "読書状態：" ]
        , renderFilterButton (state.statusFilter == Just ToRead) (FilterByStatus (Just ToRead)) "読みたい"
        , renderFilterButton (state.statusFilter == Just Reading) (FilterByStatus (Just Reading)) "読んでる"
        , renderFilterButton (state.statusFilter == Just Completed) (FilterByStatus (Just Completed)) "読んだ"
        , renderFilterButton (state.statusFilter == Nothing) (FilterByStatus Nothing) "すべて"
        ]
    , HH.div
        [ HP.class_ (H.ClassName "filter-group") ]
        [ HH.label
            [ HP.class_ (H.ClassName "filter-label") ]
            [ HH.text "優先度：" ]
        , renderFilterButton (state.priorityFilter == Just High) (FilterByPriority (Just High)) "高"
        , renderFilterButton (state.priorityFilter == Just Medium) (FilterByPriority (Just Medium)) "中"
        , renderFilterButton (state.priorityFilter == Just Low) (FilterByPriority (Just Low)) "低"
        , renderFilterButton (state.priorityFilter == Nothing) (FilterByPriority Nothing) "すべて"
        ]
    , renderCategoryFilters state.mediaItems state.categoryFilter
    ]

renderFilterButton :: forall m. Boolean -> Action -> String -> H.ComponentHTML Action () m
renderFilterButton isActive action label =
  HH.button
    [ HP.class_ (H.ClassName if isActive then "filter-button active" else "filter-button")
    , HE.onClick \_ -> action
    ]
    [ HH.text label ]

filterMediaItems :: State -> Array MediaItem
filterMediaItems state =
  state.mediaItems
    # sortBy (comparing (_.addedDate))
    # filter filterFn
  where
  filterFn item =
    (state.typeFilter == Nothing || state.typeFilter == Just item.contentType) &&
    (state.statusFilter == Nothing || state.statusFilter == Just item.status) &&
    (state.priorityFilter == Nothing || state.priorityFilter == Just item.priority) &&
    (state.categoryFilter == Nothing || containsCategory item.categories state.categoryFilter)
  
  containsCategory :: Array String -> Maybe String -> Boolean
  containsCategory _ Nothing = true
  containsCategory categories (Just category) = 
    categories # any (\cat -> cat == category)

renderCategoryFilters :: forall m. Array MediaItem -> Maybe String -> H.ComponentHTML Action () m
renderCategoryFilters items selectedCategory =
  HH.div
    [ HP.class_ (H.ClassName "filter-group category-filters") ]
    [ HH.label
        [ HP.class_ (H.ClassName "filter-label") ]
        [ HH.text "カテゴリー：" ]
    , renderFilterButton (selectedCategory == Nothing) (FilterByCategory Nothing) "すべて"
    , HH.div
        [ HP.class_ (H.ClassName "category-buttons") ]
        (allCategoriesButtons items selectedCategory)
    ]
  where
    allCategoriesButtons :: Array MediaItem -> Maybe String -> Array (H.ComponentHTML Action () m)
    allCategoriesButtons mediaItems selected =
      getAllCategories mediaItems
        # map (\cat -> renderFilterButton (selected == Just cat) (FilterByCategory (Just cat)) cat)
    
    getAllCategories :: Array MediaItem -> Array String
    getAllCategories mediaItems =
      mediaItems
        # map (_.categories)
        # fold
        # nub
        # sort

renderMediaCard :: forall m. MediaItem -> H.ComponentHTML Action () m
renderMediaCard item =
  HH.div
    [ HP.class_ (H.ClassName "media-card") ]
    [ HH.div
        [ HP.class_ (H.ClassName "media-header") ]
        [ HH.span
            [ HP.class_ (H.ClassName "media-type") ]
            [ HH.text (show item.contentType) ]
        , HH.span
            [ HP.class_ (H.ClassName "media-status") ]
            [ HH.text (show item.status) ]
        , HH.span
            [ HP.class_ (H.ClassName "media-priority") ]
            [ HH.text ("優先度: " <> show item.priority) ]
        ]
    , HH.h2_ [ HH.text item.title ]
    , HH.p [ HP.class_ (H.ClassName "media-author") ] [ HH.text ("著者: " <> item.author) ]
    , HH.div [ HP.class_ (H.ClassName "media-dates") ]
        [ HH.p [ HP.class_ (H.ClassName "media-added-date") ] [ HH.text ("追加日: " <> item.addedDate) ]
        , case item.completedDate of
            Just date -> HH.p [ HP.class_ (H.ClassName "media-completed-date") ] [ HH.text ("読了日: " <> date) ]
            Nothing -> HH.div_ []
        ]
    , HH.div [ HP.class_ (H.ClassName "media-categories") ]
        (item.categories # map renderCategoryTag)
    , case item.review of
        Just review -> HH.p [ HP.class_ (H.ClassName "media-review-preview") ] [ HH.text (truncateContent review) ]
        Nothing -> HH.p [ HP.class_ (H.ClassName "media-no-review") ] [ HH.text (if item.status == Completed then "感想はまだありません" else "") ]
    , HH.p [ HP.class_ (H.ClassName "media-link") ] 
        [ HH.a 
            [ HP.href item.link, HP.target "_blank" ] 
            [ HH.text "リンク" ]
        ]
    , HH.button
        [ HP.class_ (H.ClassName "view-details")
        , HE.onClick \_ -> ViewItem item.id
        ]
        [ HH.text "詳細を見る" ]
    ]

renderCategoryTag :: forall m. String -> H.ComponentHTML Action () m
renderCategoryTag category =
  HH.span
    [ HP.class_ (H.ClassName "category-tag")
    , HE.onClick \_ -> FilterByCategory (Just category)
    ]
    [ HH.text category ]

renderRatingStars :: forall m. Maybe Int -> H.ComponentHTML Action () m
renderRatingStars mRating =
  case mRating of
    Nothing -> HH.div_ []
    Just rating ->
      HH.div
        [ HP.class_ (H.ClassName "rating") ]
        (makeStars rating)
  where
  makeStars r = map star [ 1, 2, 3, 4, 5 ]
    where
    star i = HH.span
      [ HP.class_ (H.ClassName if i <= r then "star filled" else "star") ]
      [ HH.text "★" ]

renderItemView :: forall m. State -> Int -> H.ComponentHTML Action () m
renderItemView state itemId =
  case findItem state.mediaItems itemId of
    Nothing -> HH.div_ [ HH.text "アイテムが見つかりません" ]
    Just item ->
      HH.div
        [ HP.class_ (H.ClassName "media-full") ]
        [ HH.div [ HP.class_ (H.ClassName "media-badges") ]
            [ HH.div
                [ HP.class_ (H.ClassName "media-type-badge") ]
                [ HH.text (show item.contentType) ]
            , HH.div
                [ HP.class_ (H.ClassName "media-status-badge") ]
                [ HH.text (show item.status) ]
            , HH.div
                [ HP.class_ (H.ClassName "media-priority-badge") ]
                [ HH.text ("優先度: " <> show item.priority) ]
            ]
        , HH.h2_ [ HH.text item.title ]
        , HH.p [ HP.class_ (H.ClassName "media-author") ] [ HH.text ("著者: " <> item.author) ]
        , HH.div [ HP.class_ (H.ClassName "media-dates") ]
            [ HH.p [ HP.class_ (H.ClassName "media-added-date") ] [ HH.text ("追加日: " <> item.addedDate) ]
            , case item.completedDate of
                Just date -> HH.p [ HP.class_ (H.ClassName "media-completed-date") ] [ HH.text ("読了日: " <> date) ]
                Nothing -> HH.div_ []
            ]
        , HH.p [ HP.class_ (H.ClassName "media-link") ]
            [ HH.a
                [ HP.href item.link, HP.target "_blank" ]
                [ HH.text "リンク" ]
            ]
        , HH.div [ HP.class_ (H.ClassName "media-categories-section") ]
            [ HH.h3_ [ HH.text "カテゴリー" ]
            , HH.div [ HP.class_ (H.ClassName "media-categories") ]
                (item.categories # map renderCategoryTag)
            ]
        , HH.div
            [ HP.class_ (H.ClassName "media-review") ]
            [ HH.h3_ [ HH.text "感想" ]
            , case item.review of
                Just review -> HH.div_
                  ( review
                      # String.split (String.Pattern "\n\n")
                      # map \para -> HH.p_ [ HH.text para ]
                  )
                Nothing -> HH.p [ HP.class_ (H.ClassName "no-review") ]
                  [ HH.text (if item.status == Completed then "感想はまだありません" else "まだ読了していません") ]
            ]
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

-- ヘルパー関数
findItem :: Array MediaItem -> Int -> Maybe MediaItem
findItem items id = items # findMap \item -> if item.id == id then Just item else Nothing

truncateContent :: String -> String
truncateContent content =
  if String.length content > 150 then String.take 150 content <> "..."
  else content
