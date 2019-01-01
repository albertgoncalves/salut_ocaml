#!/usr/bin/env bash

set -e

ocamlopt -c likelihood.mli
ocamlopt -o likelihood likelihood.ml
./likelihood
