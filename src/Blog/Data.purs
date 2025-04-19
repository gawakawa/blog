module Blog.Data where

import Prelude
import Data.Maybe (Maybe(..))

-- コンテンツの種類を表す型
data ContentType = Book | Article | Paper

derive instance Eq ContentType

instance Show ContentType where
  show Book = "本"
  show Article = "記事"
  show Paper = "論文"

-- 読書状態を表す型
data ReadingStatus = ToRead | Reading | Completed

derive instance Eq ReadingStatus

instance Show ReadingStatus where
  show ToRead = "読みたい"
  show Reading = "読んでる"
  show Completed = "読んだ"

-- 優先度を表す型
data Priority = Low | Medium | High

derive instance Eq Priority

instance Show Priority where
  show Low = "低"
  show Medium = "中"
  show High = "高"

-- カテゴリーを表す型
data Category = Rust

derive instance Eq Category

instance Show Category where
  show Rust = "Rust"

-- メディアアイテムの型定義
type MediaItem =
  { id :: Int
  , title :: String
  , contentType :: ContentType
  , status :: ReadingStatus
  , priority :: Priority
  , addedDate :: String
  , completedDate :: Maybe String
  , review :: Maybe String
  , categories :: Array Category -- カテゴリータグの配列
  , link :: String -- 記事のURLまたは本の情報ページなど
  }

-- サンプルのメディアデータ
sampleMediaItems :: Array MediaItem
sampleMediaItems =
  [ { id: 1
    , title: "The Rust Programming Language"
    , contentType: Article
    , status: Reading
    , priority: Medium
    , addedDate: "2025-04-20"
    , completedDate: Nothing
    , review: Nothing
    , categories: [ Rust ]
    , link: "https://doc.rust-jp.rs/book-ja"
    }
  ]
