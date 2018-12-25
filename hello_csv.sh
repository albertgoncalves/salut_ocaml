#!/usr/bin/env bash

ocamlfind ocamlopt -package csv -linkpkg hello_csv.ml -o hello_csv
./hello_csv
