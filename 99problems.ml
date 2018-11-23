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
