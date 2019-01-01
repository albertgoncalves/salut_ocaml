module A = Array
module L = List
module R = Random

type door = Door of int * bool

let swap a i j =
    let t = a.(i) in
    a.(i) <- a.(j);
    a.(j) <- t

let shuffle a =
    let rand i = R.int (i + 1) in
    A.iteri (fun i _ -> swap a i (rand i)) a;
    a

let zip_index xs =
    let rec loop i accu = function
        | [] -> accu
        | (x::xs) -> loop (i + 1) ((i, x)::accu) xs in
    loop 0 [] xs

let doors () =
    let options = [false; false; true] in
    let doors = zip_index @@ A.to_list @@ shuffle @@ A.of_list options in
    L.map (fun (i, b) -> Door (i, b)) doors

let select k xs =
    let rec loop = function
        | Door (i, x) as d::xs -> if i = k then Some d else loop xs
        | [] -> None in
    loop xs

let exclude k xs =
    let keep k door =
        let Door (i, _) = door in
        if i = k then false else true in
    L.filter (keep k) xs

let change i xs = match (select i xs) with
    | Some Door (i, x) -> if x = true then 0 else 1
    | None -> 0

let sum = L.fold_left (+) 0

let game () =
    let xs = doors () in
    let i = R.int 2 in
    change i xs

let int_div n d =
    let n = float_of_int n and d = float_of_int d in
    n /. d

let main () =
    let x = 10000 in
    let y = sum @@ L.init x (fun _ -> game ()) in
    int_div y x
