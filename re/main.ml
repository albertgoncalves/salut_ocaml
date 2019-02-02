module R = Re

let main () =
    let re : R.re =
        R.compile @@ R.Pcre.re "[/:\\\\. (),'\"]+" in
    let s : string =
        "pNy.sQA/_\"ZHo/O:z4(6L4C,95\"I)g4d(gwZ" in
    s
    |> R.replace_string re ~by:"_"
    |> print_string

let () = main ()
