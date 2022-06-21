{
  description = "Clear's NixOS Configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    fup.url = "github:gytis-ivaskevicius/flake-utils-plus";
  };

  outputs = { self, nixpkgs, fup }@inputs:
    with builtins;
    with nixpkgs.lib;
    let
      inherit (fup.lib) mkFlake exportModules;
      pkgs = self.pkgs.x86_64-linux.nixpkgs;
    in mkFlake {
      inherit self inputs;
      supportedSystems = fup.lib.defaultSystems;

      nixosModules = exportModules [ ./hosts/nixos ];
     
      hosts = { nixos.modules = with self.nixosModules; [ nixos ] };
    
      outputsBuilder = channels: {
        devShell = channels.nixpkgs.mkShell { packages = with pkgs; [ nixfmt ] };
      };
    };
}