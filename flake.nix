{
  description = "csharp-learn — a mobile-friendly C# learning app";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      # nix run . -- 8080   → serve this static app at http://localhost:8080
      apps.${system}.default = {
        type = "app";
        meta.description = "Serve csharp-learn with a static HTTP server";
        program = toString (pkgs.writeShellScript "csharp-learn-serve" ''
          exec ${pkgs.python3}/bin/python3 -m http.server "''${1:-8000}" --directory ${self}
        '');
      };
    };
}
