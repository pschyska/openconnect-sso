{
  description = "openconnect-sso";

  inputs = {
    fup.url = "github:gytis-ivaskevicius/flake-utils-plus";
  };

  outputs = inputs@{ self, nixpkgs, fup, ... }:

    fup.lib.mkFlake {
      inherit self inputs;

      overlays.default = import ./overlay.nix;

      outputsBuilder = channels:
        let
          pkgs = channels.nixpkgs;
          sauce = (pkgs.callPackage ./nix { inherit pkgs; });
        in

        rec {
          packages = { inherit (sauce) openconnect-sso; };
          defaultPackage = packages.openconnect-sso;
          devShell = sauce.shell;
        };
    };
}
