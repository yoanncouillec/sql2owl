open Types
open Transform
open Parser
let _ = 
  let input_filename = ref "" in
  let output_filename = ref "" in
  let path = ref "http://none.com" in
  let base = ref "base" in
  let options =
    [
      "-i", Arg.Set_string input_filename, "Set input file";
      "-o", Arg.Set_string output_filename , "Set output file";
      "-p", Arg.Set_string path, "Set the based namespace";
      "-b", Arg.Set_string base, "Set the base name";
    ]
  in    
    Arg.parse options (fun x -> ()) "Options: ";
    if !input_filename != "" then begin
      output_filename := 
	(Filename.chop_suffix !input_filename ".sql") ^ ".owl" ;
      print_endline !output_filename
    end;
    let input_file = open_in !input_filename in
    let output_file = open_out !output_filename in
    let lexbuf = Lexing.from_channel input_file in
    let sql_tables = Parser.start Lexer.token lexbuf in
    let owl_tables = List.map owl_of_sql_table sql_tables in
    let header = "<?xml version=\"1.0\"?>
<!DOCTYPE rdf:RDF [
    <!ENTITY "^ !base ^" \"" ^ !path  ^ "#\" >
    <!ENTITY owl \"http://www.w3.org/2002/07/owl#\" >
    <!ENTITY xsd \"http://www.w3.org/2001/XMLSchema#\" >
    <!ENTITY rdfs \"http://www.w3.org/2000/01/rdf-schema#\" >
    <!ENTITY rdf \"http://www.w3.org/1999/02/22-rdf-syntax-ns#\" >
]>

<rdf:RDF 
    xmlns=\"" ^ !path  ^ "#\"
    xml:base=\"" ^ !path  ^ "\"
    xmlns:rdfs=\"http://www.w3.org/2000/01/rdf-schema#\"
    xmlns:owl=\"http://www.w3.org/2002/07/owl#\"
    xmlns:xsd=\"http://www.w3.org/2001/XMLSchema#\"
    xmlns:rdf=\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\"
    xmlns:"^ !base ^"=\"" ^ !path  ^ "#\"
    >

  <owl:Ontology rdf:about=\"\">
    <rdfs:comment xml:lang=\"en\"></rdfs:comment>
    <rdfs:label xml:lang=\"en\"></rdfs:label> 
  </owl:Ontology>
" 
    in
    let footer = "</rdf:RDF>\n" in
    let model = 
      List.fold_left 
	(fun a (clazz, properties) ->
	   a ^ (string_of_owl_class clazz) ^ 
	     (List.fold_left 
		(fun a b ->
		   a ^ (string_of_owl_property b))
		""
		properties)
	     (*(List.fold_left
		(fun a b ->
		   a ^ (Owl.string_of_owl_data_instance b))
		""
		instances)*)
	)
	""
	owl_tables
    in
      output_string output_file header ;
      output_string output_file model ;
      (* Data.output_data output_file sql_tables ; *)
      List.iter 
	(fun d -> output_string output_file (string_of_owl_data_instance d)) 
	(Data.transform sql_tables);
      output_string output_file footer
