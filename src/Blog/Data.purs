module Blog.Data where

import Prelude
import Data.Maybe (Maybe(..))

-- コンテンツの種類を表す型
data ContentType = Book | Article

derive instance Eq ContentType

instance Show ContentType where
  show Book = "本"
  show Article = "記事"

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

-- メディアアイテムの型定義
type MediaItem =
  { id :: Int
  , title :: String
  , author :: String
  , contentType :: ContentType
  , status :: ReadingStatus
  , priority :: Priority
  , addedDate :: String
  , completedDate :: Maybe String
  , review :: Maybe String
  , categories :: Array String -- カテゴリータグの配列
  , link :: String -- 記事のURLまたは本の情報ページなど
  }

-- サンプルのメディアデータ
sampleMediaItems :: Array MediaItem
sampleMediaItems =
  [ { id: 1
    , title: "プログラミング言語の設計と実装"
    , author: "鈴木太郎"
    , contentType: Book
    , status: Completed
    , priority: High
    , addedDate: "2025-03-01"
    , completedDate: Just "2025-03-25"
    , review: Just "コンパイラの内部構造について詳しく解説されており、自作言語の参考になった。特に型システムの実装部分が役立った。"
    , categories: ["コンパイラ", "プログラミング言語", "型システム"]
    , link: "https://example.com/compiler-book"
    }
  , { id: 2
    , title: "関数型プログラミングの基礎"
    , author: "山田花子"
    , contentType: Book
    , status: Reading
    , priority: Medium
    , addedDate: "2025-04-01"
    , completedDate: Nothing
    , review: Just "前半のモナドの解説がわかりやすい。実践的な例も多く、PureScriptの学習に役立っている。"
    , categories: ["関数型プログラミング", "モナド", "PureScript"]
    , link: "https://example.com/fp-book"
    }
  , { id: 3
    , title: "PureScriptでWebアプリケーション開発入門"
    , author: "佐藤次郎"
    , contentType: Article
    , status: Completed
    , priority: High
    , addedDate: "2025-04-10"
    , completedDate: Just "2025-04-10"
    , review: Just "Halogenフレームワークの使い方がわかりやすく解説されていて、このブログ作成の参考にした。"
    , categories: ["PureScript", "Halogen", "Web開発"]
    , link: "https://example.com/purescript-tutorial"
    }
  , { id: 4
    , title: "分散システムの原理と実践"
    , author: "高橋健太"
    , contentType: Book
    , status: ToRead
    , priority: Medium
    , addedDate: "2025-04-15"
    , completedDate: Nothing
    , review: Nothing
    , categories: ["分散システム", "ネットワーク", "システム設計"]
    , link: "https://example.com/distributed-systems"
    }
  , { id: 5
    , title: "WebAssemblyの最新動向"
    , author: "Tech Weekly"
    , contentType: Article
    , status: ToRead
    , priority: Low
    , addedDate: "2025-04-18"
    , completedDate: Nothing
    , review: Nothing
    , categories: ["WebAssembly", "ブラウザ", "Web技術"]
    , link: "https://example.com/webassembly-trends"
    }
  , { id: 6
    , title: "カテゴリー理論入門"
    , author: "佐々木理論子"
    , contentType: Book
    , status: Reading
    , priority: High
    , addedDate: "2025-04-05"
    , completedDate: Nothing
    , review: Just "プログラミングにおける抽象化の数学的基礎が理解できる。特に関手やモナドの解説がわかりやすい。"
    , categories: ["圏論", "数学", "関数型プログラミング"]
    , link: "https://example.com/category-theory"
    }
  , { id: 7
    , title: "自作OSから学ぶコンピュータの仕組み"
    , author: "田中OS郎"
    , contentType: Book
    , status: ToRead
    , priority: High
    , addedDate: "2025-04-20"
    , completedDate: Nothing
    , review: Nothing
    , categories: ["OS", "システムプログラミング", "コンピュータアーキテクチャ"]
    , link: "https://example.com/os-book"
    }
  ]