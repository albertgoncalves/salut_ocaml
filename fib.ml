(* https://github.com/dhammika-marasinghe/Learn-OCaml/tree/master/lab03%20Tail%20Recursive%20Functions *)

let fib n =
    let rec loop n a b =
        if n <= 1 then b
        else loop (n - 1) (b) (a + b) in
    loop n 0 1;;

let main () =
    let arg = int_of_string Sys.argv.(1) in
    print_int (fib arg);
    print_newline ();
    exit 0;;
main ();;
