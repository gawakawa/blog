# Contributing

## 開発環境

依存関係のセットアップは Nix + direnv 経由。`direnv allow` すればディレクトリに入るたびに
devShell が自動でロードされる。

```sh
pnpm dev         # localhost:4321 でローカルサーバーを起動
pnpm build       # ./dist/ に本番ビルドを出力
pnpm preview     # ビルド結果をローカルでプレビュー
pnpm preview:cf  # Cloudflare Workers ランタイムでプレビュー
pnpm deploy      # Cloudflare Workers にデプロイ
pnpm test        # vitest run
nix fmt          # コードを整形
nix flake check  # フォーマット・lint・型チェックをまとめて実行
```

依存関係の追加・更新は `pnpm` コマンド経由で行う（`package.json` を直接編集しない）。更新後は
`nix flake check` を実行してハッシュ不一致エラーを確認し、`got:` 行のハッシュを
`flakes/node-modules.nix` の `hash` に反映する。
