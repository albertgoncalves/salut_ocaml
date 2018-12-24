type 'a rle =
    | One of 'a
    | Many of int * 'a

let encode l =
    let rle count x =
        if count = 0 then One x else Many (count + 1, x) in
    let rec loop count accu = function
        | [] -> []
        | [x] -> (rle count x)::accu
        | a::(b::_ as t) ->
            if a = b then loop (count + 1) accu t
            else
                loop 0 ((rle count a)::accu) t in
    loop 0 [] l

let freq l_rle =
    let decode = function
        | One _ -> 1
        | Many (x, _) -> x in

    List.map (fun x -> decode x) l_rle

let main () =
    let l =
        ["a"; "a"; "a"; "a"; "b"; "c"; "c"; "a"; "a"; "d"; "e"; "e"; "e"] in
    freq @@ encode @@ List.sort compare l
