type token =
  | MAJIDENT of (string)
  | INT of (int)
  | EOF
  | LPAREN
  | RPAREN
  | SEMICOLON
  | CREATE
  | TABLE
  | REFERENCES
  | NOT
  | NULL
  | PRIMARY
  | KEY
  | VARCHAR
  | NUMBER
  | CHAR

val start :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Sql.sql_table list
