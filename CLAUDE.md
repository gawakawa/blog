# CLAUDE.md

## Commands

- `nix fmt` - Format code
- `nix flake check` - Run checks (format, lint)
- `pnpm build` - Build the project
- `pnpm test` - Run tests

## Updating dependencies

After changing dependencies, run `nix flake check` and copy the correct hash from the `got:` line in the error output into `flakes/node-modules.nix`.

## MCP

- Astro について調べる際は `astro-docs` MCP を使うこと。
