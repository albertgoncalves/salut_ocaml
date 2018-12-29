module A = Array
module L = List
module R = Random

type door = Door of int * bool

let swap a i j =
    let t = a.(i) in
    a.(i) <- a.(j);
    a.(j) <- t

let shuffle a =
    let rand i =
        let j = i + 1 in
        R.int j in
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

let select k default xs =
    let rec loop = function
        | Door (i, x)::xs ->
            if i = k then x else loop xs
        | [] -> default in
    loop xs

let keep boolean x =
    let Door (_, b) = x in
    if b = boolean then true else false

let filter_doors boolean xs =
    L.filter (keep boolean) xs

let change xs =
    let trues = filter_doors true xs in
    let falses = filter_doors false xs in
    let eliminate = function
        | [a; b] ->
            if R.float 1.0 > 0.5 then [a] else [b]
        | _ -> [] in
    L.concat [eliminate falses; trues]
