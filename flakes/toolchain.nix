{ flake-parts-lib, ... }:
{
  options.perSystem = flake-parts-lib.mkPerSystemOption (
    { lib, ... }:
    {
      options.pnpmPackage = lib.mkOption {
        type = lib.types.package;
        description = ''
          The pnpm package used throughout the project, derived from
          package.json's "packageManager" field.
        '';
      };
      options.nodejsPackage = lib.mkOption {
        type = lib.types.package;
        description = ''
          The Node.js package used throughout the project, derived from
          package.json's "engines.node" field.
        '';
      };
    }
  );

  config.perSystem =
    { pkgs, ... }:
    let
      packageJson = builtins.fromJSON (builtins.readFile ../package.json);

      pnpmMajor =
        let
          m = builtins.match "pnpm@([0-9]+)\\..*" packageJson.packageManager;
        in
        if m == null then
          throw "flakes/toolchain.nix: could not parse pnpm major version from packageManager (${packageJson.packageManager})"
        else
          builtins.elemAt m 0;

      nodeMajor =
        let
          m = builtins.match ">=([0-9]+)" packageJson.engines.node;
        in
        if m == null then
          throw "flakes/toolchain.nix: could not parse node major version from engines.node (${packageJson.engines.node})"
        else
          builtins.elemAt m 0;
    in
    {
      pnpmPackage = pkgs."pnpm_${pnpmMajor}";
      nodejsPackage = pkgs."nodejs_${nodeMajor}";
    };
}
