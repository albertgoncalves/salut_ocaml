module type X = sig
    type _ t
    val init : int -> (int -> 'a) -> 'a t
    val iter : ('a -> unit) -> 'a t -> unit
end

module type Y = sig
    type _ t
    val range : int -> int -> int t
    val print : int t -> unit
end

module F (X : X) : (Y with type 'a t := 'a X.t) = struct
    include X
    let range (a : int) (b : int) : int t =
        if a < b then
            X.init (b - a) (fun i -> i + a)
        else
            X.init (a - b) (fun i -> a - i)
    let print (xs : int t) : unit =
        X.iter (fun x -> string_of_int x |> print_endline) xs
end

module A : (X with type 'a t = 'a array) = struct
    type 'a t = 'a array
    let init = Array.init
    let iter = Array.iter
end

module L : (X with type 'a t = 'a list) = struct
    type 'a t = 'a list
    let init = List.init
    let iter = List.iter
end

module AF = F(A)
module LF = F(L)

let main () =
    LF.print (LF.range 0 10)
    ; AF.print (AF.range 10 0)

let () = main ()
