{ pkgs ? import <nixpkgs> {} }:

with pkgs; mkShell {
    name = "ocaml";

    buildInputs = [ ocaml
                    ocamlPackages.batteries
                    ocamlPackages.findlib
                    ocamlPackages.utop
                    rlwrap
                  ];

    shellHook = ''
        alias rocaml="rlwrap ocaml"
    '';
}
