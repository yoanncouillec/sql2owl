open Types
open Transform
      
let rec has_primary_key = function
  | [] -> false
  | PrimaryKey :: _ -> true
  | _ :: rest -> has_primary_key rest

let rec has_references = function
  | [] -> false
  | References (_, _) :: _ -> true
  | _ :: rest -> has_references rest

let id_from_fields =
  let rec id_from_fields l n = function
    | [] -> l
    | Field (_, _, foptions) :: rest ->
	if has_primary_key foptions 
	then [n]
	else if has_references foptions 
	then id_from_fields (n :: l) (n + 1) rest
	else id_from_fields l (n + 1) rest
  in
    id_from_fields [] 0
      
let rec get_references = function
  | [] -> failwith "No references"
  | References (_,_) as r :: _-> r
  | _ :: rest -> get_references rest

let owl_data_property_of_sql_field tablename = function
    (Field (fieldname, _, foptions), data) ->
      if has_references foptions then
	match get_references foptions with
	  | References (rtable, _) ->
	      DataObjectProperty (tablename ^ "__" ^ fieldname,
				     rtable ^ "__" ^ data)
	  | _ -> failwith "Sould not happenned"
      else
	DataDatatypeProperty (tablename ^ "__" ^ fieldname,
				 String2.html_entities data)

let transform l = 
  let transform accu = function
    | Table (tablename, fields) ->
	let id = id_from_fields fields in 
	let chan = open_in ("examples/" ^ tablename ^ ".raw") in
	let lines = ref [] in
	let owl_data_from_line line =
	  let line = Str.split_delim (Str.regexp "[\t]") line in
	    DataInstance (tablename,
			  List.fold_left 
			    (fun s n -> s ^ (List.nth line n))
			    (tablename ^ "__")
			    id,
			  List.map 
			    (owl_data_property_of_sql_field tablename) 
			    (List.combine fields line))
	in
	  try
	    while true 
	    do
	      lines := owl_data_from_line (input_line chan) :: !lines ;
	    done ;
	    accu @ !lines
	  with End_of_file ->
	    accu @ !lines
  in
    List.fold_left transform [] l

(*
  let output_data_table output_channel step = function
  | Table (tablename, fields) ->
      let count = ref 0 in
      let id = id_from_fields fields in 
      let chan = open_in ("../Data/" ^ tablename ^ ".out") in
      let lines = ref [] in
      let owl_data_from_line line =
	let line = Str.split_delim (Str.regexp "[\t]") line in
	  DataInstance (tablename,
			   List.fold_left 
			     (fun s n -> s ^ (List.nth line n))
			     (tablename ^ "__")
			     id,
			   List.map 
			     (owl_data_property_of_sql_field tablename) 
			     (List.combine fields line))
      in
	try
	  while true 
	  do
	    lines := owl_data_from_line (input_line chan) :: !lines ;
	    count := !count + 1 ;
	    if !count = step then 
	      begin
		List.iter (fun line -> 
			     output_string output_channel
			       (string_of_owl_data_instance line)) !lines ;
		lines := [];
		count := 0;
	      end
	  done
	with End_of_file ->
	    print_endline ("End of " ^ tablename)

let output_data out_channel sql_tables =
  List.iter (output_data_table out_channel 100) sql_tables
*)
