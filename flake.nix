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
            helm-docs
            kubernetes-helm
            podman
            qemu
          
            (if (system == "x86_64-linux") then [
                traceroute
                virtiofsd
              ]
            else null)
          ];
        };
      };
    };
}
