module L = List

module type Semigroup = sig
    type t
    val to_string : t -> string
end

module Utils (S: Semigroup) = struct
    let string_num x = S.to_string x
end

module IntUtils =
    Utils(struct type t = int
        let to_string : (t -> string) = string_of_int
    end)

module FloatUtils =
    Utils(struct type t = float
        let to_string : (t -> string) = string_of_float
    end)

let main () =
    L.iter print_endline [IntUtils.string_num 10; FloatUtils.string_num 10.01]

let () = main ()
