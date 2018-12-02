module L = List
module P = Printf
module R = Random
module S = String

let print_strlist l = print_string @@ P.sprintf "[%s]\n" @@ S.concat "; " l

let main () =
    let rand_list n = L.init n (fun _ -> R.float 1.0) in
    L.iter
        (fun x -> print_strlist @@ L.map string_of_float x)
        [rand_list 10; rand_list 5; rand_list 3]

let () = main ()
