#!/usr/bin/env bash

set -e

ocamlfind ocamlopt -package re -linkpkg main.ml -o main
./main
