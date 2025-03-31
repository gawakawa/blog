module Blog.Data where

import Prelude

-- ブログポストの型定義
type Post = 
  { id :: Int
  , title :: String
  , content :: String
  , date :: String
  }

-- サンプルの投稿データ
samplePosts :: Array Post
samplePosts =
  [ { id: 1
    , title: "初めての投稿"
    , content: "これは初めてのブログ投稿です。Halogenを使ってPureScriptでブログを作成しています。\n\nPureScriptは強力な型システムを持つ関数型プログラミング言語で、JavaScriptにコンパイルされます。静的型付けにより、多くのバグを未然に防ぐことができます。\n\nHalogenはPureScriptのUIフレームワークで、ReactのようなコンポーネントベースのアプローチでWebアプリケーションを構築できます。"
    , date: "2025-04-01"
    }
  , { id: 2
    , title: "PureScriptについて"
    , content: "PureScriptは強力な型システムを持つ関数型プログラミング言語です。JavaScriptにコンパイルされます。\n\n主な特徴：\n- 静的型付け\n- 型クラス\n- 代数的データ型\n- パターンマッチング\n- 純粋関数型\n- 高階関数\n\nPureScriptはHaskellに似た構文を持ちながらも、JavaScriptのエコシステムと統合しやすいように設計されています。"
    , date: "2025-04-02"
    }
  , { id: 3
    , title: "Halogenフレームワークの基本"
    , content: "Halogenは強力なPureScript用のUIフレームワークです。コンポーネントベースのアーキテクチャを提供し、型安全なUIの構築をサポートします。\n\nHalogenの主要概念：\n\n1. **コンポーネント** - 再利用可能なUI部品\n2. **State** - コンポーネントの状態を定義\n3. **Action** - ユーザー操作などのイベント\n4. **Query** - 親コンポーネントからの問い合わせ\n\nHalogenは関数型プログラミングのアプローチでUIを構築するため、副作用を制御し、予測可能な動作を実現できます。"
    , date: "2025-04-03"
    }
  ]