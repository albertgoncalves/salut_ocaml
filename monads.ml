module L = List
module P = Printf
module S = String

(* https://www.cs.cornell.edu/courses/cs3110/2019sp/textbook/ads/monads.html
 * http://blog.haberkucharsky.com/technology/2015/07/21/more-monads-in-ocaml.html
 *)

module type Monad = sig
    type _ m
    val return : 'a -> 'a m
    val (=<<) : ('a -> 'b m) -> 'a m -> 'b m
    val (>>=) : 'a m -> ('a -> 'b m) -> 'b m
end

module type Functor = sig
    type _ t
    val fmap : ('a -> 'b) -> 'a t -> 'b t
    val (<$) : 'a -> 'b t -> 'a t
end

module OptionMonad : (Monad with type 'a m = 'a option) = struct
    type 'a m = 'a option
    let return m = Some m
    let (=<<) f = function
        | None -> None
        | Some m -> f m
    let (>>=) f m = (=<<) m f
end

module OptionFunctor : (Functor with type 'a t = 'a option) = struct
    type 'a t = 'a option
    let fmap f = function
        | None -> None
        | Some a -> Some (f a)
    let (<$) a _ = Some a
end

module OM = OptionMonad
module OF = OptionFunctor

let (|@) (f : 'a -> 'b) (g : 'b -> 'c) : ('a -> 'c) = fun x -> g (f x)

let (|.) (f : 'b -> 'c) (g : 'a -> 'b) : ('a -> 'c) = fun x -> f (g x)

let int_of_string' (s : string) : int option =
    try
        Some (int_of_string s)
    with
        _ -> None

let sequence : ('a option list -> 'a list option) =
    let rec loop accu = function
        | [] -> Some accu
        | None::xs -> None
        | (Some x)::xs -> loop (x::accu) xs in
    function
        | [] -> None
        | xs -> loop [] (L.rev xs)

let string_of_opt : (string option -> string) = function
    | Some s -> P.sprintf "Some %s" s
    | None -> "None"

let pipeline : (string -> unit) =
    S.split_on_char ' '
    |@ L.map (OM.(=<<) int_of_string' |. (fun x -> Some x))
    |@ sequence
    |@ OF.fmap (S.concat " " |. L.map string_of_int)
    |@ string_of_opt
    |@ print_endline

let main () : unit = pipeline "1 2 3 4"

let () = main ()
