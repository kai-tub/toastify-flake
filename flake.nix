{
  description = "A flake that wraps toastify";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        # To import a flake module
        # 1. Add foo to inputs
        # 2. Add foo as a parameter to the outputs function
        # 3. Add here: foo.flakeModule

      ];
      systems = [ "x86_64-linux" "aarch64-darwin" ];
      perSystem = { config, self', inputs', pkgs, system, lib, ... }: {
        # Per-system attributes can be defined here. The self' and inputs'
        # module parameters provide easy access to attributes of the same
        # system.

        # Equivalent to  inputs'.nixpkgs.legacyPackages.hello;
        packages.toastify = pkgs.rustPlatform.buildRustPackage rec {
          pname = "toastify";
          version = "v0.5.2";

          src = pkgs.fetchFromGitHub {
            owner = "hoodie";
            repo = pname;
            rev = version;
            sha256 = "fCwxFdpwtG83xw3DDt9rlnbY8V3eKemRFK/6E1Bhm4c=";
          };

          cargoSha256 = "gk76Qg5Ojk6IbRkuSo/r69V9yI9GSBr8qA9M4RQIQWc=";

          meta = with lib; {
            description = "A commandline tool that shows desktop notifications using notify-rust";
          };
        };
      };
      flake = {
        # The usual flake attributes can be defined here, including system-
        # agnostic ones like nixosModule and system-enumerating ones, although
        # those are more easily expressed in perSystem.

      };
    };
}
