{
  description = "A collection of my Helm charts";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  inputs.flake-parts.url = "github:hercules-ci/flake-parts";

  outputs = inputs@{ self, flake-parts, nixpkgs }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-darwin"
      ];

      perSystem = { lib, pkgs, system, ... }: {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            cocogitto
            helm-docs
            git
            kubernetes-helm
            pre-commit
            yq

            (writeShellScriptBin "ci-release" ''
              git config user.name $GIT_USER_NAME
              git config user.email $GIT_USER_EMAIL
              echo $REGISTRY_PASSWORD | helm registry login $REGISTRY -u $REGISTRY_USERNAME --password-stdin
              helm repo add bjw-s https://bjw-s.github.io/helm-charts
              cog bump --auto
            '')
          ];
        };
      };
    };
}
