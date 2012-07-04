type owl_data_property =
  | DataObjectProperty of string * string
  | DataDatatypeProperty of string * string

type owl_data_instance = 
  | DataInstance of string * string * owl_data_property list

let string_of_owl_data_property = function
  | DataObjectProperty (tag, data) ->
      "<" ^ tag ^ " rdf:resource=\"#" ^ data ^ "\" />\n"
  | DataDatatypeProperty (tag, data) ->
      "<" ^ tag ^ ">" ^ data ^ "</" ^ tag ^ ">\n" 

let string_of_owl_data_instance = function
  | DataInstance (tag, about, properties) ->
      "<" ^ tag ^ " rdf:about=\"#" ^ about ^ "\">\n" ^
	(List.fold_left 
	   (fun a b -> a ^ (string_of_owl_data_property b)) 
	   "" 
	   properties) ^
	"</" ^ tag ^ ">\n"

let rec has_primary_key = function
  | [] -> false
  | Sql.PrimaryKey :: _ -> true
  | _ :: rest -> has_primary_key rest

let rec has_references = function
  | [] -> false
  | Sql.References (_, _) :: _ -> true
  | _ :: rest -> has_references rest

let id_from_fields =
  let rec id_from_fields l n = function
    | [] -> l
    | Sql.Field (_, _, foptions) :: rest ->
	if has_primary_key foptions 
	then [n]
	else if has_references foptions 
	then id_from_fields (n :: l) (n + 1) rest
	else id_from_fields l (n + 1) rest
  in
    id_from_fields [] 0
      
let rec get_references = function
  | [] -> failwith "No references"
  | Sql.References (_,_) as r :: _-> r
  | _ :: rest -> get_references rest

let owl_data_property_of_sql_field tablename = function
    (Sql.Field (fieldname, _, foptions), data) ->
      if has_references foptions then
	match get_references foptions with
	  | Sql.References (rtable, _) ->
	      DataObjectProperty (tablename ^ "__" ^ fieldname,
				     rtable ^ "__" ^ data)
	  | _ -> failwith "Sould not happenned"
      else
	DataDatatypeProperty (tablename ^ "__" ^ fieldname,
				 String2.html_entities data)

let output_data_table output_channel step = function
  | Sql.Table (tablename, fields) ->
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
