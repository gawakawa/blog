# PureScript ブログ

PureScriptとHalogenで作られた静的ブログアプリケーションです。

## 機能

- ブログ記事一覧表示
- 記事の詳細表示
- レスポンシブデザイン

## セットアップ

必要なもの:
- Node.js & npm
- PureScriptツールチェーン

インストール手順:

```bash
# 依存関係のインストール
npm install
# またはyarnを使用する場合
yarn
```

## 開発サーバーの起動

```bash
spago build
spago run
```

## ディレクトリ構造

```
/src
  /Blog
    /Components    # 共通コンポーネント
    /Data.purs     # ブログデータ
  /CSS.purs        # スタイル
  /Main.purs       # メインコンポーネント
/test              # テスト
```

## ブログ記事の追加方法

`src/Blog/Data.purs` ファイルに新しい記事を追加できます。
必要な項目:
- id (一意の識別子)
- title (記事タイトル)
- content (記事の内容)
- date (公開日)

## 技術スタック

- PureScript
- Halogen (UIフレームワーク)
- Spago (パッケージマネージャ)