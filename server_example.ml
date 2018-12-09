(* ocamlfind ocamlopt -thread -package cohttp-lwt-unix -linkpkg server_example.ml -o server_example *)

open Cohttp
open Lwt

module CL = Cohttp_lwt
module CLU = Cohttp_lwt_unix
module LM = Lwt_main
module P = Printf

let body_contents body uri meth headers =
    P.sprintf
        "Body: %s\n\nUri: %s\n\nMethod: %s\n\nHeaders: \n%s"
        body uri meth headers

let server =
    let callback _conn req body =
        let uri = req |> CLU.Request.uri |> Uri.to_string in
        let meth = req |> CLU.Request.meth |> Code.string_of_method in
        let headers = req |> CLU.Request.headers |> Header.to_string in

        body
        |> CL.Body.to_string
        >|= (fun body -> body_contents body uri meth headers)
        >>= (fun body -> CLU.Server.respond_string ~status:`OK ~body ()) in

    CLU.Server.create ~mode:(`TCP (`Port 8000)) (CLU.Server.make ~callback ())

let () = ignore (LM.run server)
