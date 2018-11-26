#!/usr/bin/env bash

PATH=`cat .nix_path`
ocamlfind ocamlopt -package cohttp-lwt-unix -linkpkg server_example.ml -o server_example
./server_example
