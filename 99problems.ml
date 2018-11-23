(* https://ocaml.org/learn/tutorials/99problems.html *)

let rec fac = function
    | 0 -> 1
    | n -> n * (fac [@tailcall]) (n - 1);;
let lst = [1;2;3;4];;

let rec last l =
    match l with
    | [] -> None
    | x :: [] -> Some x
    | _ :: xs -> (last [@tailcall]) xs;;

let rec last_two l =
    match l with
    | [] | _ :: [] -> None
    | x :: xx :: [] -> Some [x; xx]
    | _ :: xs -> (last_two [@tailcall]) xs;;

let rec at n l =
    if n < 1 then None
    else
        match (n, l) with
        | _, [] -> None
        | 1, (x :: _) -> Some x
        | n, (_ :: xs) -> (at [@tailcall]) (n - 1) xs;;

let rec rev l =
    let rec loop l rev_l =
        match (l, rev_l) with
        | [], rev -> rev
        | (x :: xs), rev -> (loop [@tailcall]) xs (x :: rev)
    in loop l [];;


type 'a node =
    | One of 'a
    | Many of 'a node list;;

let nest_lst =
    [ One "a" ; Many [ One "b" ; Many [ One "c" ; One "d" ] ; One "e" ] ];;

let rec flatten ll =
    match ll with
    | [] -> []
    | One x :: xs -> x :: (flatten [@tailcall]) xs
    | Many xs :: xa -> flatten xs @ flatten xa;;

let dupe_lst =
    ["a"; "a"; "a"; "a"; "b"; "c"; "c"; "a"; "a"; "d"; "e"; "e"; "e"; "f"];;

let rec compress l =
    match l with
    | [] -> []
    | x :: [] -> [x]
    | x :: (xx :: xs) ->
        if x = xx then compress (xx :: xs)
        else x :: compress (xx :: xs);;

let rec pack l : 'a list list =
    let rec loop l inner outer =
        match (l, inner, outer) with
        | [], i, o -> o @ [i]
        | (x :: xs), [], o -> loop xs [x] o
        | (x :: xs), (i :: is), o ->
            let ia = (i :: is) in
                if x = i then (loop [@tailcall]) xs (x :: ia) o
                else (loop [@tailcall]) xs [x] (o @ [ia])
    in loop l [] [];;
