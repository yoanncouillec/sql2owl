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

val string_of_owl_class : owl_class -> string
val string_of_owl_property : owl_property -> string


