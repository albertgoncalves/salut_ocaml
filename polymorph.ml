module type Semigroup = sig
    type t
    val to_string : t -> string
    val to_int : t -> int
end

module Utils (S : Semigroup) = struct
    let string_num x = (S.to_string x) ^ " is a string"
    let force_int x = 10000 + S.to_int x
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

module L = List
module I = IntUtils
module F = FloatUtils

let (@.) (f : ('b -> 'c)) (g : ('a -> 'b)) : ('a -> 'c) = fun x -> f @@ g x

let flip (f : ('a -> 'b -> 'c)) = fun x y -> f y x

let main () =
    L.iter print_endline [I.string_num 10; F.string_num 10.01];
    flip L.iter
        [I.force_int 20; F.force_int 20.012]
        (print_endline @. I.string_num)

let () = main ()
