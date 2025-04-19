# This file is a non-flake alternative for nix-build
# To build: nix-build

let
  lock = builtins.fromJSON (builtins.readFile ./flake.lock);
  
  nixpkgsLocked = fetchTarball {
    url = "https://github.com/nixos/nixpkgs/archive/${lock.nodes.nixpkgs.locked.rev}.tar.gz";
    sha256 = lock.nodes.nixpkgs.locked.narHash;
  };
  
  purescript-overlayLocked = fetchTarball {
    url = "https://github.com/thomashoneyman/purescript-overlay/archive/${lock.nodes.purescript-overlay.locked.rev}.tar.gz";
    sha256 = lock.nodes.purescript-overlay.locked.narHash;
  };
  
  pkgs = import nixpkgsLocked {
    overlays = [
      (import purescript-overlayLocked).overlays.default
    ];
  };
in

pkgs.stdenv.mkDerivation {
  name = "ps-blog";
  src = ./.;
  
  nativeBuildInputs = with pkgs; [
    purs
    spago-unstable
    nodejs_22
    git
  ];
  
  buildPhase = ''
    export HOME=$TMPDIR
    export CI=true
    export GIT_SSL_CAINFO="${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt"
    npm install --no-save --no-audit --no-fund --no-interactive
    npm run build -- --emptyOutDir --mode=production
  '';
  
  installPhase = ''
    mkdir -p $out
    cp -r dist/* $out/
  '';
}
