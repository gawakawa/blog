# CLAUDE.md

## Development

- 開発環境については CONTRIBUTING.md を参照。

## Updating dependencies

After changing dependencies, run `nix flake check` and copy the correct hash from the `got:` line in the error output into `flakes/node-modules.nix`.

## MCP

- Astro について調べる際は `astro-docs` MCP を使うこと。
