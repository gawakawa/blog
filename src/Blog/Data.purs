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

data ReadingStatus = ToRead | Reading | Completed

derive instance Eq ReadingStatus

instance Show ReadingStatus where
  show ToRead = "読みたい"
  show Reading = "読んでる"
  show Completed = "読んだ"

data Priority = Low | Medium | High

derive instance Eq Priority

instance Show Priority where
  show Low = "低"
  show Medium = "中"
  show High = "高"

data Category = Rust | Compiler | Network | Effect | Logic | TypeScript | TypeSystem | Continuation | BuildYourOwnX

derive instance Eq Category

instance Show Category where
  show Rust = "Rust"
  show Compiler = "コンパイラ"
  show Network = "ネットワーク"
  show Effect = "エフェクト"
  show Logic = "論理学"
  show TypeScript = "TypeScript"
  show TypeSystem = "型システム"
  show Continuation = "継続"
  show BuildYourOwnX = "自作"

type MediaItem =
  { id :: Int
  , title :: String
  , contentType :: ContentType
  , status :: ReadingStatus
  , priority :: Priority
  , addedDate :: String
  , completedDate :: Maybe String
  , review :: Maybe String
  , categories :: Array Category
  , link :: String
  }

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
  , { id: 2
    , title: "低レイヤを知りたい人のためのCコンパイラ作成入門"
    , contentType: Article
    , status: ToRead
    , priority: Medium
    , addedDate: "2025-04-20"
    , completedDate: Nothing
    , review: Nothing
    , categories: [ Compiler ]
    , link: "https://www.sigbus.info/compilerbook"
    }
  , { id: 3
    , title: "プロフェッショナルIPv6"
    , contentType: Book
    , status: ToRead
    , priority: Low
    , addedDate: "2025-04-20"
    , completedDate: Nothing
    , review: Nothing
    , categories: [ Network ]
    , link: "https://www.sigbus.info/compilerbook"
    }
  , { id: 4
    , title: "【Rust】Base64を実装する"
    , contentType: Article
    , status: ToRead
    , priority: Medium
    , addedDate: "2025-04-20"
    , completedDate: Nothing
    , review: Nothing
    , categories: [ Rust ]
    , link: "https://qiita.com/k-yaina60/items/c37882c3a78337b269f0"
    }
  , { id: 5
    , title: "An Introduction to Algebraic Effects and Handlers. Invited tutorial paper"
    , contentType: Paper
    , status: Reading
    , priority: High
    , addedDate: "2025-04-20"
    , completedDate: Nothing
    , review: Nothing
    , categories: [ Effect ]
    , link: "https://www.sciencedirect.com/science/article/pii/S1571066115000705"
    }
  , { id: 6
    , title: "計算論理と人間の思考　推論AIへの論理的アプローチ"
    , contentType: Book
    , status: Reading
    , priority: Medium
    , addedDate: "2025-04-20"
    , completedDate: Nothing
    , review: Nothing
    , categories: [ Logic ]
    , link: "https://www.amazon.co.jp/%E8%A8%88%E7%AE%97%E8%AB%96%E7%90%86%E3%81%A8%E4%BA%BA%E9%96%93%E3%81%AE%E6%80%9D%E8%80%83-%E6%8E%A8%E8%AB%96AI%E3%81%B8%E3%81%AE%E8%AB%96%E7%90%86%E7%9A%84%E3%82%A2%E3%83%97%E3%83%AD%E3%83%BC%E3%83%81-%E3%83%AD%E3%83%90%E3%83%BC%E3%83%88%E3%83%BB%E3%82%B3%E3%83%AF%E3%83%AB%E3%82%B9%E3%82%AD/dp/4909240063"
    }
  , { id: 7
    , title: "型システムのしくみ ― TypeScriptで実装しながら学ぶ型とプログラミング言語"
    , contentType: Book
    , status: ToRead
    , priority: High
    , addedDate: "2025-04-20"
    , completedDate: Nothing
    , review: Nothing
    , categories: [ TypeSystem ]
    , link: "https://www.lambdanote.com/products/type-systems"
    }
  , { id: 8
    , title: "Compiling with Continuations"
    , contentType: Book
    , status: ToRead
    , priority: High
    , addedDate: "2025-04-21"
    , completedDate: Nothing
    , review: Nothing
    , categories: [ Continuation ]
    , link: "https://www.amazon.co.jp/Compiling-Continuations-English-Andrew-Appel-ebook/dp/B00E3UR010/ref=tmm_kin_swatch_0"

    }
  , { id: 9
    , title: "Build a Frontend Web Framework (From Scratch)"
    , contentType: Book
    , status: ToRead
    , priority: High
    , addedDate: "2025-04-21"
    , completedDate: Nothing
    , review: Nothing
    , categories: [ BuildYourOwnX ]
    , link: "https://github.com/angelsolaorbaiceta/fe-fwk-book?tab=readme-ov-file"
    }
  ]
