(* This file is part of the tutorial
   http://cairo.forge.ocamlcore.org/tutorial/
*)

let () =
    let surface =
        Cairo.Image.create Cairo.Image.ARGB32 ~width:120 ~height:120 in
    let cr = Cairo.create surface in
    (* Examples are in 1.0 x 1.0 coordinate space *)
    Cairo.scale cr 120.0 120.0;

    (* Drawing code goes here *)
    Cairo.set_line_width cr 0.1;
    Cairo.set_source_rgb cr 0.0 0.0 0.0;
    Cairo.rectangle cr ~x:0.25 ~y:0.25 ~w:0.5 ~h:0.5;
    Cairo.stroke cr;

    (* Write output *)
    Cairo.PNG.write surface "stroke.png"
