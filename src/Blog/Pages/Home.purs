module Blog.Pages.Home where

import Prelude

import Blog.Data (MediaItem, ContentType(..), ReadingStatus(..), Priority(..), Category(..))
import Blog.Types (State, Action(..))
import Blog.Utils (truncateContent)
import Data.Maybe (Maybe(..))
import Data.Array (sortBy, filter, any)
import Halogen as H
import Halogen.HTML as HH
import Halogen.HTML.Events as HE
import Halogen.HTML.Properties as HP

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
  
  containsCategory :: Array Category -> Maybe Category -> Boolean
  containsCategory _ Nothing = true
  containsCategory categories (Just category) = 
    categories # any (\cat -> cat == category)

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
        , renderFilterButton (state.typeFilter == Just Paper) (FilterByType (Just Paper)) "論文"
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
    , renderCategoryFilters state.categoryFilter
    ]

renderCategoryFilters :: forall m. Maybe Category -> H.ComponentHTML Action () m
renderCategoryFilters selectedCategory =
  HH.div
    [ HP.class_ (H.ClassName "filter-group category-filters") ]
    [ HH.label
        [ HP.class_ (H.ClassName "filter-label") ]
        [ HH.text "カテゴリー：" ]
    , renderFilterButton (selectedCategory == Nothing) (FilterByCategory Nothing) "すべて"
    , HH.div
        [ HP.class_ (H.ClassName "category-buttons") ]
        (allCategoriesButtons selectedCategory)
    ]
  where
    allCategoriesButtons :: Maybe Category -> Array (H.ComponentHTML Action () m)
    allCategoriesButtons selected =
      getAllCategories
        # map (\cat -> renderFilterButton (selected == Just cat) (FilterByCategory (Just cat)) (show cat))
    
    getAllCategories :: Array Category
    getAllCategories = 
      [ Rust
      ]

renderCategoryTag :: forall m. Category -> H.ComponentHTML Action () m
renderCategoryTag category =
  HH.span
    [ HP.class_ (H.ClassName "category-tag")
    , HE.onClick \_ -> FilterByCategory (Just category)
    ]
    [ HH.text (show category) ]

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