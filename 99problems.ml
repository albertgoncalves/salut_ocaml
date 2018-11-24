(* https://ocaml.org/learn/tutorials/99problems.html *)

let lst = [1; 2; 3; 4];;

let fac n =
    let rec loop acc = function
        | 0 -> acc
        | n -> (loop [@tailcall]) (acc * n) (n - 1)
    in loop 1 n;;

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

let rev l =
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

let flatten l =
    let rec loop acc = function
        | [] -> acc
        | One x :: xs -> (loop [@tailcall]) (x :: acc) xs
        | Many xs :: xa -> (loop [@tailcall]) (loop acc xs) xa
    in loop [] l;;

let dupe_lst =
    ["a"; "a"; "a"; "a"; "b"; "c"; "c"; "a"; "a"; "d"; "e"; "e"; "e"; "f"];;

let rec compress l =
    match l with
    | [] -> []
    | x :: [] -> [x]
    | x :: (xx :: xs) ->
        if x = xx then compress (xx :: xs)
        else x :: compress (xx :: xs);;

let pack l =
    let rec loop l inner outer =
        match (l, inner, outer) with
        | [], i, o -> o @ [i]
        | (x :: xs), [], o -> loop xs [x] o
        | (x :: xs), (i :: is), o ->
            let ia = (i :: is) in
                if x = i then (loop [@tailcall]) xs (x :: ia) o
                else (loop [@tailcall]) xs [x] (o @ [ia])
    in loop l [] [];;

let drop l nth =
    let rec loop l n nth =
        if nth < 1 then l
        else
            match (l, n, nth) with
            | [], _, _ -> []
            | (x :: xs), n, nth ->
                if n mod nth = 0 then loop xs (n + 1) nth
                else x :: loop xs (n + 1) nth
    in loop l 1 nth;;

let range a b =
    let d = if a > b then (-1) else 1 in
    let rec loop a b x =
        let aa = (a @ [x]) in
            if x = b then aa
            else loop aa b (x + d)
    in loop [a] b (a + d);;

let is_prime m =
    if m < 2 then false
    else
        let rec loop m = function
            | 1 -> true
            | n ->
                if m mod n <> 0 then loop m (n - 1)
                else false
        in loop m (m - 1);;

let rec gcd a b =
    if b = 0 then a
    else gcd b (a mod b);;

let coprime a b =
    gcd a b = 1;;

let phi m =
    if m = 1 then 1
    else if m < 1 then 0
    else
        let rec loop m n = function
        | 1 -> n
        | r ->
            if coprime m r then loop m (n + 1) (r - 1)
            else loop m n (r - 1)
        in loop m 1 (m - 1);;

let factors m =
    let rec loop m f fs =
        if m = 1 then fs
        else
            if m mod f = 0 then (loop [@tailcall]) (m / f) f (f :: fs)
            else (loop [@tailcall]) m (f + 1) fs
    in loop m 2 [];;

let pow n p =
    let rec loop n p acc =
        if p < 1 then acc
        else loop n (p - 1) (acc * n)
    in loop n p 1;;
