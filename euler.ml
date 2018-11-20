open Batteries

(* https://github.com/ocaml-batteries-team/batteries-included/wiki/Getting-started *)

let main () =
    (1--999)
    |> Enum.filter (fun i -> i mod 3 = 0 || i mod 5 = 0)
    |> Enum.reduce (+)
    |> Int.print stdout

let () = main ()
