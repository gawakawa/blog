module Blog.Pages.ItemView where

import Prelude

import Blog.Data (ReadingStatus(..))
import Blog.Types (State, Action(..))
import Blog.Utils (findItem)
import Blog.Pages.Home (renderCategoryTag)
import Data.Maybe (Maybe(..))
import Data.String as String
import Halogen as H
import Halogen.HTML as HH
import Halogen.HTML.Events as HE
import Halogen.HTML.Properties as HP

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