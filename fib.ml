(* https://github.com/dhammika-marasinghe/Learn-OCaml/tree/master/lab03%20Tail%20Recursive%20Functions *)

let fib n =
    let rec loop i a b =
        if i = n then a
        else loop (i + 1) (b) (a + b) in
    loop 0 0 1;;

let main () =
    let arg = int_of_string Sys.argv.(1) in
    print_int (fib arg);
    print_newline ();
    exit 0;;
main ();;
