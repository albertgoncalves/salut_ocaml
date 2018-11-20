# Salut, OCaml!

Greetings to **OCaml** via **Nix**.

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
89
```

Or, without creating an executable:
```bash
$ ocaml fib.ml 20
10946
```

---
Use [Findlib](http://projects.camlcity.org/projects/findlib.html) to link in packages:
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
    (1--999)
    |> Enum.filter (fun i -> i mod 3 = 0 || i mod 5 = 0)
    |> Enum.reduce (+)
    |> Int.print stdout
    |> print_newline

let () = main ();;
233168
val main : unit -> unit = <fun>
```
