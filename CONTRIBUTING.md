# Contributing

## 開発環境

依存関係のセットアップは Nix + direnv 経由。`direnv allow` すればディレクトリに入るたびに
devShell が自動でロードされる。

```sh
pnpm dev      # localhost:4321 でローカルサーバーを起動
pnpm build    # ./dist/ に本番ビルドを出力
pnpm preview  # ビルド結果をローカルでプレビュー
pnpm test     # vitest run
```

依存関係の追加・更新は `pnpm` コマンド経由で行う（`package.json` を直接編集しない）。更新後は
`nix flake check` を実行してハッシュ不一致エラーを確認し、`got:` 行のハッシュを
`flakes/node-modules.nix` の `hash` に反映する。

## デプロイ構成

このブログは Astro の完全な静的サイト（SSG）。SSR を使わないため `@astrojs/cloudflare` などの
adapter は導入せず、`astro build` が出力する `dist/` を Cloudflare Workers の静的アセット配信
機能でそのまま公開している（[Astro 公式ガイド](https://docs.astro.build/en/guides/deploy/cloudflare/)
が新規プロジェクトに推奨する構成）。設定は `wrangler.jsonc` にある。

ビルドは Nix 上で行う（`flakes/packages.nix` の `packages.site`）。この derivation は
`packages.default` としても、`flakes/checks.nix` の `checks.site` としても参照されている。
後者により、PR での `nix flake check` が毎回サイトのビルドを実行し、壊れた MDX や content の
ミスを CI の時点で検出できる。

```sh
nix build .#site   # dist 相当を ./result に生成
```

## CI/CD

- **PR**: `.github/workflows/ci.yml` が `nix flake check` を実行する（テスト・lint・フォーマット・
  サイトビルドを含む）。
- **`main` への push**: `.github/workflows/deploy.yml` が `nix build .#site` → Wrangler で
  Cloudflare Workers にデプロイする。`main` は PR 通過後にマージされるため、CI は push 時には
  再実行しない（冗長な二重実行を避けている）。

デプロイ手動実行は `workflow_dispatch` からも可能。

### 必要な GitHub Secrets / Environment

デプロイジョブは GitHub の `prd` Environment に紐づいている。同 Environment に以下の Secrets を
登録すること:

| Secret                  | 用途                                 |
| :---------------------- | :----------------------------------- |
| `CLOUDFLARE_API_TOKEN`  | 権限スコープ: `Workers Scripts:Edit` |
| `CLOUDFLARE_ACCOUNT_ID` | デプロイ先アカウントの ID            |

`CACHIX_AUTH_TOKEN` は CI と共用のためリポジトリレベルの Secret のまま。

初回の `wrangler deploy` で Worker `blog` が自動作成され、`https://blog.<アカウントの
サブドメイン>.workers.dev` で配信される（現時点ではカスタムドメイン未設定）。

wrangler は `package.json` の devDependencies には含めていない（依存ツリーが大きく、Nix の
`node-modules.nix` ハッシュ更新を誘発するため）。CI は `cloudflare/wrangler-action` の
`wranglerVersion` でバージョンを固定している。ローカルで wrangler を使う場合は
`pnpm dlx wrangler <command>` を使う。

```sh
pnpm build && pnpm dlx wrangler dev    # ローカルで Workers ランタイム上のプレビュー
```

## 今後の予定

カスタムドメイン（`blog.i0ta.dev`）の割り当ては次のフェーズで対応する。`wrangler.jsonc` に
`routes` を追記し、`CLOUDFLARE_API_TOKEN` に `Workers Routes:Edit` と該当 zone の DNS 編集権限を
追加する必要がある。
