{
  description = "optional description";

  nixConfig.bash-prompt = ''\033[1;32m\[[nix-develop:\[\033[36m\]\w\[\033[32m\]]$\033[0m '';

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/23.11-pre";
    whacked-setup = {
      url = "github:whacked/setup/70344e985d5a6e246f7bdfa10869211ce0b5e634";
      flake = false;
    };
  };
  outputs = { self, nixpkgs, flake-utils, whacked-setup }:
    flake-utils.lib.eachDefaultSystem
    (system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
      whacked-helpers = import (whacked-setup + /nix/flake-helpers.nix) { inherit pkgs; };
    in {
      devShell = whacked-helpers.mkShell {
        flakeFile = __curPos.file;  # used to forward current file to echo-shortcuts
        includeScripts = [
          # e.g. for node shortcuts
          # (whacked-setup + /bash/node_shortcuts.sh)
        ];
      } {
        buildInputs = [
          pkgs.poetry
        ];

        shellHook = ''
          # e.g.
          alias dev='npm dev'
        '';  # join strings with +
      };
    }
  );
}
