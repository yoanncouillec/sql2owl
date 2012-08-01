open Types

(* SQL -> OWL *)
let owl_type_base_of_sql_type = function
  | Varchar _ | Char _ -> String
  | Number _ -> Int

let rec owl_of_sql_options tablename fieldname owl_base_type = function
  | [] -> DatatypeProperty (tablename ^ "__" ^ fieldname, 
			    tablename, 
			    owl_base_type)
  | References (rtablename, rfield) :: _ ->
      ObjectProperty (tablename ^ "__" ^ fieldname, tablename, rtablename)
  | _ :: rest -> owl_of_sql_options tablename fieldname owl_base_type rest

let owl_of_sql_field tablename = function
  | Field (fieldname, ftype, foptions) ->
      owl_of_sql_options 
	tablename 
	fieldname 
	(owl_type_base_of_sql_type ftype)
	foptions

let owl_of_sql_table = function
  | Table (tablename, fields) -> 
      (Class (tablename), 
       List.map (owl_of_sql_field tablename) fields)
