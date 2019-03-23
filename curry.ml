let curry (f : ('a * 'b) -> 'c) (a : 'a) (b : 'b) : ('c) = f (a, b)

let uncurry (f : 'a -> 'b -> 'c) (ab : ('a * 'b)) : ('c) =
    let (a, b) = ab in
    f a b

let f (xy : (int * int)) : (int) =
    let (x, y) = xy in
    x * y

let g (x : int) (y : int) : int = x * y

let main () =
    [ curry f 10 20
    ; uncurry g (10, 20)
    ]
    |> List.map string_of_int
    |> String.concat "\n"
    |> print_endline

let () = main ()
