(********** 
    OWL
**********)
type owl_type_base =
  | Int
  | String 

type owl_class =
  | Class of string

type owl_property = 
  | ObjectProperty of string * string * string
  | DatatypeProperty of string * string * owl_type_base

type owl_ontology = 
  | Ontology of string * string

type owl_data_property =
  | DataObjectProperty of string * string
  | DataDatatypeProperty of string * string

type owl_data_instance = 
  | DataInstance of string * string * owl_data_property list

(**********
    SQL
**********)
type sql_type = 
  | Varchar of int
  | Number of int
  | Char of int

type sql_option = 
  | NotNull
  | PrimaryKey
  | References of string * string

type sql_field = 
  | Field of string * sql_type * sql_option list

type sql_table = 
  | Table of string * sql_field list

(* Owl -> String *)
let string_of_owl_base_type = function
  | Int -> "int"
  | String -> "string"

let string_of_owl_class = function
  | Class s ->
      "<owl:Class rdf:about=\"#" ^ s ^ "\" />\n"

let string_of_owl_property = function
  | ObjectProperty (name, domain, range) ->
      "<owl:ObjectProperty rdf:about=\"#" ^ name ^ "\">" ^
	"<rdfs:domain rdf:resource=\"#" ^ domain ^ "\" />" ^
	"<rdfs:range rdf:resource=\"#" ^ range ^ "\" />" ^
	"</owl:ObjectProperty>\n"
  | DatatypeProperty (name, domain, range) ->
      "<owl:DatatypeProperty rdf:about=\"#" ^ name ^ "\">" ^
	"<rdfs:domain rdf:resource=\"#" ^ domain ^ "\" />" ^
	"<rdfs:range rdf:resource=\"" ^ (string_of_owl_base_type range) ^ 
	"\" />" ^ 
	"</owl:DatatypeProperty>\n"

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
