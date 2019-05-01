let (|.) (f : 'b -> 'c) (g : 'a -> 'b) : ('a -> 'c) = fun x -> f (g x)
let (>>) (a : unit -> 'a) (b : unit -> 'b) : 'b = a () |> (fun _ -> b ())

module type T = sig
    type _ t
    val init : int -> (int -> 'a) -> 'a t
    val iter : ('a -> unit) -> 'a t -> unit
end

module F (X : T) = struct
    include X
    let range (a : int) (b : int) : int t =
        if a < b then
            X.init (b - a) (fun i -> i + a)
        else
            X.init (a - b) (fun i -> a - i)
    let print (f : (int -> string)) (xs : int t) : unit =
        let a () = X.iter (print_string |. f) xs in
        let b () = print_string "\n" in
        a >> b
end

module A = struct
    include Array
    include
        F ( struct type 'a t = 'a array
            let init = Array.init
            let iter = Array.iter end
        )
end

module L = struct
    include List
    include
        F ( struct type 'a t = 'a list
            let init = List.init
            let iter = List.iter end
        )
end

let main () =
    let l () = L.print string_of_int (L.range 0 10) in
    let a () = A.print string_of_int (A.range 9 (-1)) in
    l >> a

let () = main ()
