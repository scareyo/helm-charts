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

        apps.ci-bump.program = pkgs.writeShellApplication {
          name = "ci-bump";
          runtimeInputs = with pkgs; [
            cocogitto

            (writeShellScriptBin "ci-cog-pre-bump" ''
              VERSION=$1

              yq -i ".version = \"$VERSION\"" Chart.yaml
              yq -i ".appVersion = \"$(yq .controllers.main.containers.main.image.tag values.yaml)\" | .appVersion style=\"double\"" Chart.yaml

              helm-docs

              # disable_changelog isn't respected for monorepo
              rm CHANGELOG.md
            '')

            (writeShellScriptBin "ci-cog-post-bump" "")
          ];
          text = ''
            cog bump --auto
          '';
        };

        apps.ci-check.program = pkgs.writeShellApplication {
          name = "ci-check";
          runtimeInputs = with pkgs; [
            chart-testing
            kind
            kubernetes-helm
          ];
          text = ''
            kind create cluster
            helm repo add bjw-s https://bjw-s.github.io/helm-charts

            readarray -t changed < <(ct list-changed)

            echo "detected changes in the following charts:"
            echo "''${changed[@]}"

            # TODO: Allow more than one chart to change at a time. Some charts
            #       are too powerful to be tested by GitHub Actions runners.
            if (( ''${#changed[@]} > 1 )); then
              echo "More than one chart has changes"
              exit 1
            fi

            if [ "''${changed[0]}" == "charts/vintagestory" ]; then
              ct lint
            else
              ct lint-and-install
            fi
          '';
        };

        apps.ci-release.program = pkgs.writeShellApplication {
          name = "ci-release";
          runtimeInputs = with pkgs; [
            cocogitto
            gh

            (writeShellScriptBin "ci-cog-pre-bump" "")

            (writeShellScriptBin "ci-cog-post-bump" ''
              PACKAGE=$1
              VERSION=$2

              tag="$PACKAGE-$VERSION"

              git push origin tag "$tag"

              echo $REGISTRY_PASSWORD | helm registry login $REGISTRY -u $REGISTRY_USERNAME --password-stdin
              helm repo add bjw-s https://bjw-s.github.io/helm-charts
              helm dependency build .
              helm package .
              helm push "$tag.tgz" oci://ghcr.io/scareyo

              # This parses the correct package from the `cog changelog` output
              notes=$(cog changelog -a $tag | awk -v label="# $tag" '$0 ~ label {f=1} f && /^- - -$/ {exit} f { sub(/[ \t\r]+$/, ""); if ($0 != "") print }')
              gh release create "$tag" --title "$tag" --notes "$notes"
            '')
          ];
          text = ''
            cog bump --auto --disable-bump-commit
          '';
        };

        apps.ci-renovate.program = pkgs.writeShellApplication {
          name = "ci-renovate";
          runtimeInputs = with pkgs; [
            helm-docs
            yq-go
          ];
          text = ''
            CHART=$1
            VERSION_TO_BUMP=''${2:-"patch"}

            chartVersion=$(grep '^version:' "charts/$CHART/Chart.yaml" | awk '{print $2}')
            major=$(echo "''${chartVersion}" | cut -d. -f1)
            minor=$(echo "''${chartVersion}" | cut -d. -f2)
            patch=$(echo "''${chartVersion}" | cut -d. -f3)

            if [ "$VERSION_TO_BUMP" == "patch" ]; then
              patch=$((patch + 1))
            fi

            if [ "$VERSION_TO_BUMP" == "minor" ]; then
              minor=$((minor + 1))
              patch="0"
            fi

            if [ "$VERSION_TO_BUMP" == "major" ]; then
              major=$((major + 1))
              minor="0"
              patch="0"
            fi
              
            yq -i ".version = \"$major.$minor.$patch\"" charts/"$CHART"/Chart.yaml
            yq -i ".appVersion = \"$(yq .controllers.main.containers.main.image.tag charts/"$CHART"/values.yaml)\" | .appVersion style=\"double\"" charts/"$CHART"/Chart.yaml

            helm-docs
          '';
        };

        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            chart-testing
            cocogitto
            git
            helm-docs
            k9s
            kind
            kubectl
            kubernetes-helm
            pre-commit
            yq-go
          ];
        };
      };
    };
}
