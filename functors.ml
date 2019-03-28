(* http://blog.haberkucharsky.com/technology/2015/07/21/more-monads-in-ocaml.html
*)

module type Monad = sig
    type _ t
    val pure : 'a -> 'a t
    val bind : ('a -> 'b t) -> 'a t -> 'b t
end

module type Monad' = sig
    type _ t
    include Monad with type 'a t := 'a t
    val (>>=) : 'a t -> ('a -> 'b t) -> 'b t
    val (=<<) : ('a -> 'b t) -> 'a t -> 'b t
    val join : 'a t t -> 'a t
    val sequence : 'a t list -> 'a list t
end

module MonadPlus(M : Monad) : (Monad' with type 'a t := 'a M.t) = struct
    include M
    let (>>=) m f = M.bind f m
    let (=<<) f m = M.bind f m
    let join maa = maa >>= fun ma -> ma
    let sequence mas =
        List.fold_left
            begin
                fun xs x ->
                    xs >>= fun xs' ->
                    x >>= fun x' ->
                    pure (x'::xs')
            end
            (pure [])
            mas
end

module type Functor = sig
    type _ t
    val map : ('a -> 'b) -> 'a t -> 'b t
end

module FunctorFromMonad(M : Monad) : (Functor with type 'a t = 'a M.t) = struct
    type 'a t = 'a M.t
    let map f ma = M.bind (fun a -> M.pure (f a)) ma
end

module OptionMonad : (Monad with type 'a t = 'a option) = struct
    type 'a t = 'a option
    let pure a = Some a
    let bind f = function
        | None -> None
        | Some a -> f a
end

module OM = MonadPlus(OptionMonad)

module OF = FunctorFromMonad(OptionMonad)

let main () =
    (Some 3)
    |> OF.map (fun x -> x + 3)
    |> OM.(=<<) (fun x -> Some (x + 5))
    |> OF.map string_of_int
    |> OF.map print_endline
    |> (fun _ -> ())

let () = main ()
