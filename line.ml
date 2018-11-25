(* https://www.xquartz.org/
 * ocamlfind ocamlopt -package graphics -linkpkg line.ml -o line *)

Graphics.open_graph " 200x200";;

let f x = x + 1 in
for i = 0 to 200 do
    Graphics.plot i (f i)
done

let rec interactive () =
    let event = Graphics.wait_next_event [Key_pressed] in
    if event.key == 'q' then exit 0
    else print_char event.key; print_newline (); interactive ()

let () = interactive ()
