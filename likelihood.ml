module L = List
module R = Random

let flips n p =
    let flip p =
        if R.float 1.0 <= p then 1 else 0 in
    L.init n (fun _ -> flip p)

let sum l =
    let rec loop accu = function
        | [] -> accu
        | x::xs -> loop (accu + x) xs in
    loop 0 l

let results n m p =
    L.init m (fun _ -> sum @@ flips n p)

let equals k l =
    let rec loop accu = function
        | [] -> accu
        | x::xs ->
            let accu =
                if x = k then accu + 1 else accu in
            loop accu xs in
    loop 0 l

let int_div n d =
    let n = float_of_int n and d = float_of_int d in
    n /. d

let main () =
    let x = 100000 in
    let y = equals 6 @@ results 9 x 0.5 in
    int_div y x
