# Salut, OCaml!

Getting started with **OCaml**.

Needed things
---
  * [Nix](https://nixos.org/nix/)

---
Enter the **OCaml** development environment:
```bash
$ nix-shell
```

To compile and execute via native code:
```bash
$ ocamlopt -o fib fib.ml
$ ./fib 10
55
```

Or, without creating an executable:
```bash
$ ocaml fib.ml 20
6765
```

---
Use [Findlib](http://projects.camlcity.org/projects/findlib.html) to link imported packages:
```bash
$ ocamlfind ocamlopt -package batteries -linkpkg euler.ml -o euler
$ ./euler
233168
```

Alternatively, to execute package-dependent code in the colorful REPL:
```bash
$ utop
```
```utop
utop # #use "topfind";;
utop # #require "batteries";;
utop # open Batteries;;
utop # let main () =
    (1--998)
    |> Enum.filter (fun i -> i mod 3 = 0 || i mod 5 = 0)
    |> Enum.reduce (+)
    |> Int.print stdout
    |> print_newline
let () = main ();;
232169
val main : unit -> unit = <fun>
```

If you want to import a `.ml` file into the REPL:
```utop
utop # #use "topfind";;
utop # #require "batteries";;
utop # #use "euler.ml";;
val main : unit -> unit = <fun>
utop # main ();;
233168- : unit = ()
```

---
To clean things up a little bit:
```bash
$ ocp-indent -i 99problems.ml
```

---
Turns out there are [Cairo](https://www.cairographics.org/cairo-ocaml/) bindings:
```bash
$ ocamlfind ocamlopt -package cairo2 -linkpkg stroke.ml -o stroke
$ ./stroke
$ open stroke.png
```

---
If you have [X11](https://en.wikipedia.org/wiki/X_Window_System), you can play around with the core [Graphics](https://caml.inria.fr/pub/docs/manual-ocaml/libref/Graphics.html) library:
```bash
$ ocamlfind ocamlopt -package graphics -linkpkg line.ml -o line
$ ./line
```

---
To serve up local files in the vein of **Python**'s `SimpleHTTPServer`:
```bash
$ cohttp-server-lwt
```

A few examples snagged from [ocaml-cohttp](https://github.com/mirage/ocaml-cohttp) can be used to test out basic HTTP client and server functionality:
```bash
$ ocamlfind ocamlopt -package cohttp-lwt-unix -linkpkg client_example.ml -o client_example
$ ./client_example
```

```bash
$ ocamlfind ocamlopt -package cohttp-lwt-unix -linkpkg server_example.ml -o server_example
$ ./server_example
```
