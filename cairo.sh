#!/usr/bin/env bash

ocamlfind ocamlopt -package cairo2 -linkpkg $1.ml -o $1
./$1
open $1.png
