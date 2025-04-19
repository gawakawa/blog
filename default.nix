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
  name = "purescript-blog";
  src = ./.;
  
  nativeBuildInputs = with pkgs; [
    purs
    spago-unstable
    nodejs_23
    git
  ];
  
  buildPhase = ''
    export HOME=$TMPDIR
    export GIT_SSL_CAINFO="${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt"
    spago build
    npm install --no-save
    npm run build
  '';
  
  installPhase = ''
    mkdir -p $out
    cp -r dist/* $out/
  '';
}
