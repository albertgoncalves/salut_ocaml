(* https://ocaml.org/learn/tutorials/99problems.html *)

let lst = [1;2;3;4];;

let rec last l =
    match l with
    | [] -> None
    | x :: [] -> Some x
    | _ :: xs -> last xs;;

let rec last_two l =
    match l with
    | [] | _ :: [] -> None
    | x :: xx :: [] -> Some [x; xx]
    | _ :: xs -> last_two xs;;

let rec at n l =
    if n < 1 then None
    else
        match (n, l) with
        | _, [] -> None
        | 1, (x :: _) -> Some x
        | n, (_ :: xs) -> at (n - 1) xs;;

let rec rev l =
    let rec loop l rev_l =
        match (l, rev_l) with
        | [], rev -> rev
        | (x :: xs), rev -> loop xs (x :: rev)
    in loop l [];;
