module L = List
module C = Csv

let print_column = function
    | [_; column] -> print_endline column
    | _ -> ()

let main () =
    L.iter print_column @@ L.tl @@ C.load "example.csv"

let () = main ()
