module R = Re

let main () =
    let s : string =
        "pNy.sQA/_\"ZHo/O:z4(6L4C,95\"I)g4d(gwZ" in
    let re : R.re =
        R.compile @@ R.Pcre.re "[/:\\\\. (),'\"]+" in
    print_string @@ R.replace_string re ~by:"_" s

let () = main ()
