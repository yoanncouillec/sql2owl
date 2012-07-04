let owl_type_base_of_sql_type = function
  | Sql.Varchar _ | Sql.Char _ -> Owl.String
  | Sql.Number _ -> Owl.Int

let rec owl_of_sql_options tablename fieldname owl_base_type = function
  | [] -> Owl.DatatypeProperty (tablename ^ "__" ^ fieldname, 
			    tablename, 
			    owl_base_type)
  | Sql.References (rtablename, rfield) :: _ ->
      Owl.ObjectProperty (tablename ^ "__" ^ fieldname, tablename, rtablename)
  | _ :: rest -> owl_of_sql_options tablename fieldname owl_base_type rest

let owl_of_sql_field tablename = function
  | Sql.Field (fieldname, ftype, foptions) ->
      owl_of_sql_options 
	tablename 
	fieldname 
	(owl_type_base_of_sql_type ftype)
	foptions

let owl_of_sql_table = function
  | Sql.Table (tablename, fields) -> 
      (Owl.Class (tablename), 
       List.map (owl_of_sql_field tablename) fields)
