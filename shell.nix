{ pkgs ? import <nixpkgs> {} }:
with pkgs; mkShell {
    name = "OCaml";
    buildInputs = [ ocaml-ng.ocamlPackages_4_07.ocaml
                    ocaml-ng.ocamlPackages_4_07.cairo2
                    ocaml-ng.ocamlPackages_4_07.batteries
                    ocaml-ng.ocamlPackages_4_07.cohttp-lwt-unix
                    ocaml-ng.ocamlPackages_4_07.csv
                    ocaml-ng.ocamlPackages_4_07.re
                    # ocaml-ng.ocamlPackages_4_07.core
                    ocaml-ng.ocamlPackages_4_07.findlib
                    ocaml-ng.ocamlPackages_4_07.ocp-indent
                    ocaml-ng.ocamlPackages_4_07.utop
                    rlwrap
                    tmux
                    clang
                    python36Packages.csvkit
                  ];
    shellHook = ''
        alias rocaml="rlwrap ocaml"
        echo $PATH > .nix_path

        if [ $(uname -s) = "Darwin" ]; then
            alias ls='ls --color=auto'
            alias ll='ls -al'
        fi
    '';
}
