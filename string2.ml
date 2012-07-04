(* Module String2 *)

let split s =
  let rec split s accu = 
    let len = String.length s in
      if len = 0 then List.rev accu 
      else split (String.sub s 1 (len-1)) ((String.sub s 0 1) :: accu)
  in
    split s []
      
let join l = 
  let rec join l accu = 
    match l with
      | [] -> accu
      | c :: rest -> join rest (accu ^ c)
  in
    join l ""

let escape_char = function
  | "<" -> "&lt;"
  | ">" -> "&gt;"
  | "&" -> "&amp;"
  | "\"" -> "&quot;"
  | _ as c -> c

let html_entities s =
  join (List.map escape_char (split s))
