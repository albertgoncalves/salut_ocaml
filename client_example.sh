#!/usr/bin/env bash

ocamlfind ocamlopt -package cohttp-lwt-unix -linkpkg client_example.ml -o client_example
./client_example
