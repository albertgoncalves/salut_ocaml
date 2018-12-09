(* http://scylardor.fr/2013/10/14/ocaml-parsing-a-programs-arguments-with-the-arg-module/ *)

let main =
    let arg_bool = ref false in
    let arg_int = ref 100 in
    let arg_str = ref "." in

    let arg_list = [ ( "-b"
                     , Arg.Set arg_bool
                     , "bool (default: false)"
                     )
                   ; ( "-i"
                     , Arg.Int (fun arg -> arg_int := arg)
                     , "integer (default: 100)"
                     )
                   ; ( "-s"
                     , Arg.String (fun arg -> arg_str := arg)
                     , "string (default: \".\")"
                     )
                   ] in

    let help = "Options available:" in

    Arg.parse arg_list print_endline help;

    print_endline ("bool: " ^ string_of_bool !arg_bool);
    print_endline ("integer: " ^ string_of_int !arg_int);
    print_endline ("string: " ^ !arg_str)

let () = main
