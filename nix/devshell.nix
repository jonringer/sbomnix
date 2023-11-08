{
  perSystem = {
    pkgs,
    self',
    ...
  }: {
    devShells.default = let
      pythonPackages = pkgs.python3Packages;
      inherit (self'.packages) nixupdate nix_visualize requests-ratelimiter repology_cli vulnix vulnxscan;
    in
      pkgs.mkShell rec {
        name = "sbomnix-dev-shell";

        inherit nixupdate nix_visualize requests-ratelimiter repology_cli vulnix vulnxscan;

        buildInputs = [
          nixupdate
          nix_visualize
          requests-ratelimiter
          repology_cli
          vulnix
          vulnxscan
          pkgs.coreutils
          pkgs.curl
          pkgs.gnugrep
          pkgs.gnused
          pkgs.graphviz
          pkgs.grype
          pkgs.gzip
          pkgs.nix
          pkgs.reuse
          pythonPackages.beautifulsoup4
          pythonPackages.colorlog
          pythonPackages.graphviz
          pythonPackages.numpy
          pythonPackages.packageurl-python
          pythonPackages.packaging
          pythonPackages.pandas
          pythonPackages.requests
          pythonPackages.requests-cache
          pythonPackages.tabulate
          pythonPackages.venvShellHook
          pythonPackages.wheel
        ];
        venvDir = "venv";
        postShellHook = ''
          source $PWD/scripts/env.sh

          # https://github.com/NixOS/nix/issues/1009:
          export TMPDIR="/tmp"

          # Enter python development environment
          make install-dev
        '';
      };
  };
}