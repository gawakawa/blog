{ flake-parts-lib, ... }:
{
  options.perSystem = flake-parts-lib.mkPerSystemOption (
    { lib, ... }:
    {
      options.ciPackages = lib.mkOption {
        type = lib.types.listOf lib.types.package;
        default = [ ];
        description = "Packages for CI environment";
      };
    }
  );

  config.perSystem =
    { config, pkgs, ... }:
    {
      ciPackages = with pkgs; [
        pnpm
        nodejs_24
      ];

      packages = rec {
        ci = pkgs.buildEnv {
          name = "ci";
          paths = config.ciPackages;
        };

        site = pkgs.stdenvNoCC.mkDerivation {
          name = "site";
          src = ./..;

          nativeBuildInputs = [
            pkgs.nodejs_24
            pkgs.pnpm_10
          ];

          buildPhase = ''
            runHook preBuild
            export HOME="$(mktemp -d)" # sandbox's default $HOME isn't writable
            export ASTRO_TELEMETRY_DISABLED=1
            # run from $HOME, not the project dir: pnpm inside a dir with a
            # "packageManager" field tries to fetch/verify that version first
            (cd "$HOME" && pnpm config set manage-package-manager-versions false)
            source ${config.packages.nodeModulesSetup}
            pnpm build
            runHook postBuild
          '';

          installPhase = ''
            runHook preInstall
            cp -r dist $out
            runHook postInstall
          '';
        };

        default = site;
      };
    };
}
