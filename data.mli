type owl_data_property =
  | DataObjectProperty of string * string
  | DataDatatypeProperty of string * string

type owl_data_instance = 
  | DataInstance of string * string * owl_data_property list

val output_data : out_channel -> Sql.sql_table list -> unit
