#!/usr/bin/env bash

set -e

ocamlc -c likelihood.mli
ocamlopt -c likelihood.ml
ocamlopt -o likelihood likelihood.cmx
./likelihood
