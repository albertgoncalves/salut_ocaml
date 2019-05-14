{ pkgs ? import <nixpkgs> {} }:
with pkgs; mkShell {
    name = "OCaml";
    buildInputs = [
        (with ocaml-ng.ocamlPackages_4_07; [
            ocaml
            cairo2
            batteries
            cohttp-lwt-unix
            csv
            re
            findlib
            ocp-indent
            utop
        ])
        rlwrap
        tmux
        clang
    ] ++ (with python37Packages; [
        (csvkit.overridePythonAttrs (oldAttrs: {checkPhase = "true";}))
    ]);
    shellHook = ''
        alias rocaml="rlwrap ocaml"
        echo $PATH > .nix_path

        if [ $(uname -s) = "Darwin" ]; then
            alias ls='ls --color=auto'
            alias ll='ls -al'
        fi
    '';
}
