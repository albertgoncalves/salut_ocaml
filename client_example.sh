#!/usr/bin/env bash

PATH=`cat .nix_path`
ocamlfind ocamlopt -package cohttp-lwt-unix -linkpkg client_example.ml -o client_example
./client_example
