{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    purescript-overlay = {
      url = "github:thomashoneyman/purescript-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { 
      self,
      nixpkgs,
      flake-utils,
      purescript-overlay,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ purescript-overlay.overlays.default ];
        };
      in
      {
        packages = {
          # 依存が多すぎて fetch でこける
          default = pkgs.stdenv.mkDerivation {
            name = "ps-blog";
            src = ./.;
            
            nativeBuildInputs = with pkgs; [
              purs
              spago-unstable
              nodejs_20
              git
            ];
            
            unpackPhase = ''
              cp -r $src/. .
              chmod -R u+w .
            '';
            
            buildPhase = ''
              export HOME=$TMPDIR
              export CI=true
              export GIT_SSL_CAINFO="${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt"

              npm install --no-save --no-audit --no-fund --no-interactive
              
              spago fetch
              spago build --pure
              
              npx vite build -- --emptyOutDir --mode=production
            '';
            
            installPhase = ''
              mkdir -p $out
              cp -r dist/* $out/
            '';
          };
        };

        devShells.default = pkgs.mkShell {
          name = "ps-blog-dev";
          buildInputs = with pkgs; [
            purs
            spago-unstable
            purs-tidy
            purs-backend-es
            purescript-language-server
            nodejs_22
            esbuild
          ];
        };
      }
    );
}
