%{
  open Types
%}
%token<string> MAJIDENT
%token<int> INT
%token EOF LPAREN RPAREN SEMICOLON CREATE TABLE REFERENCES NOT NULL PRIMARY KEY
%token VARCHAR NUMBER CHAR
%start start
%type <Types.sql_table list> start

%%

start: 
| tables EOF { $1 }

tables:
| table { [$1] }
| table tables { $1 :: $2 }

table:
| CREATE TABLE MAJIDENT LPAREN fields RPAREN { Table ($3, $5) }

fields:
| field { [$1] }
| field SEMICOLON fields { $1 :: $3 }

field:
| MAJIDENT ftype { Field ($1, $2, []) }
| MAJIDENT ftype foptions { Field ($1, $2, $3) }

foptions:
| foption { [$1] }
| foption foptions { $1 :: $2 }

foption:
| NOT NULL { NotNull }
| PRIMARY KEY { PrimaryKey }
| REFERENCES MAJIDENT LPAREN MAJIDENT RPAREN { References ($2, $4) }

ftype:
| VARCHAR LPAREN INT RPAREN { Varchar ($3) }
| NUMBER LPAREN INT RPAREN { Number ($3) }
| CHAR LPAREN INT RPAREN { Char ($3) }
