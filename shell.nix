{ pkgs ? import <nixpkgs> {} }:

with pkgs; mkShell {
    name = "ocaml";

    buildInputs = [ ocaml-ng.ocamlPackages_4_07.ocaml
                    ocaml-ng.ocamlPackages_4_07.core
                    ocaml-ng.ocamlPackages_4_07.batteries
                    ocaml-ng.ocamlPackages_4_07.findlib
                    ocaml-ng.ocamlPackages_4_07.utop
                    ocaml-ng.ocamlPackages_4_07.ocp-indent
                    ocaml-ng.ocamlPackages_4_07.cairo2
                    rlwrap
                    tmux
                    xquartz
                  ];

    shellHook = ''
        alias rocaml="rlwrap ocaml"
    '';
}
