_: {
  perSystem =
    { config, pkgs, ... }:
    {
      pre-commit.settings.hooks = {
        treefmt.enable = true;
        statix.enable = true;
        deadnix.enable = true;
        actionlint.enable = true;
        zizmor = {
          enable = true;
          args = [ "--offline" ];
        };
        oxlint = {
          enable = true;
          name = "oxlint";
          extraPackages = [ pkgs.nodejs_24 ]; # tsgolint (type-aware) needs node
          entry = toString (
            pkgs.writeShellScript "oxlint-entry" ''
              source ${config.packages.nodeModulesSetup}
              # .astro/types.d.ts declares astro:content etc.; regenerate it
              # via `astro sync` only when stale (it's a full Vite startup).
              types=.astro/types.d.ts
              if [ ! -e "$types" ] \
                || [ astro.config.mjs -nt "$types" ] \
                || [ src/content.config.ts -nt "$types" ] \
                || find src/content -newer "$types" -print -quit | grep -q .; then
                node_modules/.bin/astro sync
              fi
              exec ${pkgs.oxlint}/bin/oxlint
            ''
          );
          files = "\\.(ts|tsx|js|jsx)$";
          pass_filenames = false;
        };
        workflow-timeout = {
          enable = true;
          name = "Check workflow timeout-minutes";
          package = pkgs.check-jsonschema;
          entry = "${pkgs.check-jsonschema}/bin/check-jsonschema --builtin-schema github-workflows-require-timeout";
          files = "\\.github/workflows/.*\\.ya?ml$";
        };
      };
    };
}
