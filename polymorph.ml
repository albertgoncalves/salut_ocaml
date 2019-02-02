module L = List

module type Semigroup = sig
    type t
    val to_string : t -> string
    val to_int : t -> int
end

module Utils (S: Semigroup) = struct
    let string_num = S.to_string
    let force_int = S.to_int
end

module IntUtils = Utils
        ( struct type t = int
            let to_string : (t -> string) = string_of_int
            let to_int : (t -> int) = fun x -> x end
        )

module FloatUtils = Utils
        ( struct type t = float
            let to_string : (t -> string) = string_of_float
            let to_int : (t -> int) = int_of_float end
        )

let (@.) (f : ('b -> 'c)) (g : ('a -> 'b)) : ('a -> 'c) = fun x -> f @@ g x

let flip (f : ('a -> 'b -> 'c)) = fun x y -> f y x

let main () =
    L.iter print_endline [IntUtils.string_num 10; FloatUtils.string_num 10.01];
    flip L.iter
        [IntUtils.force_int 20; FloatUtils.force_int 20.012]
        (print_endline @. IntUtils.string_num)

let () = main ()
