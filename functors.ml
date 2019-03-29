module L = List
module P = Printf
module S = String

(* http://blog.haberkucharsky.com/technology/2015/07/21/more-monads-in-ocaml.html
*)

let (|@) (f : 'a -> 'b) (g : 'b -> 'c) : ('a -> 'c) = fun x -> g (f x)

let (|.) (f : 'b -> 'c) (g : 'a -> 'b) : ('a -> 'c) = fun x -> f (g x)

let id (x : 'a) : 'a = x

module type Monad = sig
    type _ m
    val pure : 'a -> 'a m
    val bind : ('a -> 'b m) -> 'a m -> 'b m
end

module type Functor = sig
    type _ t
    val map : ('a -> 'b) -> 'a t -> 'b t
end

module type Show = sig
    type _ s
    val show : ('a -> string) -> 'a s -> string
end

module type Monad' = sig
    type _ m
    include Monad with type 'a m := 'a m
    val (>>=) : 'a m -> ('a -> 'b m) -> 'b m
    val (=<<) : ('a -> 'b m) -> 'a m -> 'b m
    val join : 'a m m -> 'a m
    val sequence : 'a m list -> 'a list m
    val (>=>) : ('a -> 'b m) -> ('b -> 'c m) -> ('a -> 'c m)
    val (<=<) : ('b -> 'c m) -> ('a -> 'b m) -> ('a -> 'c m)
    val ap : ('a -> 'b) m -> 'a m -> 'b m
end

module MonadPlus(M : Monad) : (Monad' with type 'a m := 'a M.m) = struct
    include M
    let (>>=) m f = M.bind f m
    let (=<<) f m = M.bind f m
    let join m = m >>= fun m' -> m'
    let sequence mas =
        List.fold_left
            begin
                fun ms m ->
                    ms >>= fun ms' ->
                    m >>= fun m' ->
                    pure (m'::ms')
            end
            (pure [])
            mas
    let (>=>) f g = fun m -> f m >>= g
    let (<=<) g f = fun m -> f m >>= g
    let ap f m =
        f >>= fun f' ->
        m >>= fun m' -> pure (f' m')
end

module FunctorFromMonad(M : Monad) : (Functor with type 'a t = 'a M.m) = struct
    type 'a t = 'a M.m
    let map f x = M.bind (fun x' -> M.pure (f x')) x
end

module OptionMonad : (Monad with type 'a m = 'a option) = struct
    type 'a m = 'a option
    let pure m = Some m
    let bind f = function
        | None -> None
        | Some m -> f m
end

module OptionShow : (Show with type 'a s = 'a option) = struct
    type 'a s = 'a option
    let show f = function
        | Some x -> P.sprintf "Some %s" (f x)
        | None -> "None"
end

module ListMonad : (Monad with type 'a m = 'a list) = struct
    type 'a m = 'a list
    let pure x = [x]
    let bind f =
        let rec loop accu = function
            | [] -> accu
            | (x::xs) ->
                let f' = L.rev |. f in
                loop (L.rev_append (f' x) accu) xs in
        function
            | [] -> []
            | xs -> loop [] (L.rev xs)
end

module ListShow : (Show with type 'a s = 'a list) = struct
    type 'a s = 'a list
    let show f = P.sprintf "[%s]" |. S.concat "; " |. L.map f
end

module LS = ListShow
module OF = FunctorFromMonad(OptionMonad)
module OM = MonadPlus(OptionMonad)
module OS = OptionShow

let pipeline : (int -> string) =
    OM.(<=<) (fun x -> Some (x + 5)) (fun x -> Some (x * 3))
    |@ OF.map (fun x -> x + 3)
    |@ OM.ap @@ Some (fun x -> x + 1)
    |@ OM.(=<<) (fun x -> Some (x + 5))
    |@ OS.show string_of_int

let main () : unit =
    [3; 50; 0]
    |> L.map pipeline
    |> LS.show id
    |> print_endline

let () = main ()
