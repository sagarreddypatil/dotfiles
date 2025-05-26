{
  description = "Sagar's Darwin Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
  let
    configuration = { pkgs, ... }: {
      environment.systemPackages = let
        packageList = builtins.fromJSON (builtins.readFile ./packages.json);
        packageObjs  = map (name: pkgs.${name}) packageList;
      in
        packageObjs;

      fonts.packages = [
        pkgs.nerd-fonts.iosevka
      ];

      nix.settings.experimental-features = "nix-command flakes";
      programs.zsh.enable = true;
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 6;

      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#muon
    darwinConfigurations."muon" = nix-darwin.lib.darwinSystem {
      modules = [ configuration ];
    };
  };
}
