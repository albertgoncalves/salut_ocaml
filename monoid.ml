module L = List

module type Monoid = sig
    type t
    val append : t -> t -> t
    val empty : t
    val to_string : t -> string
end

module Ops (M : Monoid) = struct
    let sum_list : ('a list -> 'a) = function
        | [] -> M.empty
        | (x::xs) -> L.fold_left M.append x xs
    let to_string : ('a -> string) = M.to_string
end

module I =
    Ops
        ( struct type t = int
            let append = (+)
            let empty = 0
            let to_string = string_of_int end
        )

module F =
    Ops
        ( struct type t = float
            let append = (+.)
            let empty = 0.0
            let to_string = string_of_float end
        )

module S =
    Ops
        ( struct type t = string
            let append = (^)
            let empty = ""
            let to_string = fun s -> s end
        )

let main () : unit =
    L.iter
        print_endline
        [ I.to_string @@ I.sum_list [1; 2; 3; 4]
        ; F.to_string @@ F.sum_list [1.0; 2.0; 3.0; 4.0]
        ; S.sum_list ["a"; "b"; "c"; "d"]
        ]

let () = main ()
