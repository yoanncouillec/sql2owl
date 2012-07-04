{
  open Parser
}
rule token = parse
  | eof { EOF }
  | [' ' '\t' '\n'] { token lexbuf }
  | '(' { LPAREN }
  | ')' { RPAREN }
  | ',' { SEMICOLON }
  | "CREATE" { CREATE }
  | "TABLE" { TABLE }
  | "REFERENCES" { REFERENCES }
  | "NOT" { NOT }
  | "NULL" { NULL }
  | "PRIMARY" { PRIMARY } 
  | "KEY" { KEY }
  | "varchar" { VARCHAR }
  | "number" { NUMBER }
  | "char" { CHAR }
  | ['0'-'9']+ { INT (int_of_string (Lexing.lexeme lexbuf)) }
  | ['A'-'Z''_''0'-'9']+ { MAJIDENT (Lexing.lexeme lexbuf) }
