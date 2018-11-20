{ pkgs ? import <nixpkgs> {} }:

with pkgs; mkShell {
    name = "ocaml";

    buildInputs = [ ocaml-ng.ocamlPackages_4_07.ocaml
                    ocaml-ng.ocamlPackages_4_07.batteries
                    ocaml-ng.ocamlPackages_4_07.findlib
                    ocaml-ng.ocamlPackages_4_07.utop
                    rlwrap
                  ];

    shellHook = ''
        alias rocaml="rlwrap ocaml"
    '';
}
