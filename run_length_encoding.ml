module L = List
module P = Printf
module S = String

type 'a rle =
    | One of 'a
    | Many of int * 'a

let encode (l : 'a list) : 'a rle list =
    let rle (count : int) (x : 'a) : 'a rle =
        if count = 0 then One x else Many (count + 1, x) in
    let rec loop (count : int) (accu : 'a rle list)
        : ('a list -> 'a rle list) = function
        | [] -> []
        | [x] -> (rle count x)::accu
        | a::(b::_ as t) ->
            if a = b then loop (count + 1) accu t
            else
                loop 0 ((rle count a)::accu) t in
    loop 0 [] l

let freq (l_rle : 'a rle list) : int list =
    let decode = function
        | One _ -> 1
        | Many (x, _) -> x in

    List.map (fun x -> decode x) l_rle

let print_strlist (l : string list) =
    print_string @@ P.sprintf "[%s]\n" @@ S.concat "; " l

let main () =
    let l =
        ["a"; "a"; "a"; "a"; "b"; "c"; "c"; "a"; "a"; "d"; "e"; "e"; "e"] in
    let xs = freq @@ encode @@ List.sort compare l in
    print_strlist @@ L.map string_of_int xs

let () = main ()
