type 'a format_string = ('a, unit, string) format

let (%) = Printf.sprintf
let (<|) f x = f x

let x : 'a format_string = "%d %s %d"

let y : string = (x % 1) "a" 1
let z : string = x % 1 <| "a" <| 1  (* same as y *)

let () = List.iter print_endline [y; z]
