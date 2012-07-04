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

open Parsing;;
let yytransl_const = [|
    0 (* EOF *);
  259 (* LPAREN *);
  260 (* RPAREN *);
  261 (* SEMICOLON *);
  262 (* CREATE *);
  263 (* TABLE *);
  264 (* REFERENCES *);
  265 (* NOT *);
  266 (* NULL *);
  267 (* PRIMARY *);
  268 (* KEY *);
  269 (* VARCHAR *);
  270 (* NUMBER *);
  271 (* CHAR *);
    0|]

let yytransl_block = [|
  257 (* MAJIDENT *);
  258 (* INT *);
    0|]

let yylhs = "\255\255\
\001\000\002\000\002\000\003\000\004\000\004\000\005\000\005\000\
\007\000\007\000\008\000\008\000\008\000\006\000\006\000\006\000\
\000\000"

let yylen = "\002\000\
\002\000\001\000\002\000\006\000\001\000\003\000\002\000\003\000\
\001\000\002\000\002\000\002\000\005\000\004\000\004\000\004\000\
\002\000"

let yydefred = "\000\000\
\000\000\000\000\000\000\017\000\000\000\000\000\000\000\001\000\
\003\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\004\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\008\000\000\000\006\000\000\000\000\000\000\000\
\000\000\011\000\012\000\010\000\014\000\015\000\016\000\000\000\
\000\000\013\000"

let yydgoto = "\002\000\
\004\000\005\000\006\000\013\000\014\000\018\000\027\000\028\000"

let yysindex = "\001\000\
\006\255\000\000\004\255\000\000\013\000\006\255\013\255\000\000\
\000\000\012\255\015\255\247\254\014\255\016\255\017\255\019\255\
\020\255\248\254\000\000\015\255\022\255\023\255\024\255\018\255\
\007\255\021\255\000\000\248\254\000\000\025\255\026\255\027\255\
\029\255\000\000\000\000\000\000\000\000\000\000\000\000\033\255\
\031\255\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\027\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\032\255\000\000\000\000\
\000\000\003\255\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\005\255\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000"

let yygindex = "\000\000\
\000\000\022\000\000\000\017\000\000\000\000\000\010\000\000\000"

let yytablesize = 38
let yytable = "\024\000\
\025\000\001\000\026\000\015\000\016\000\017\000\007\000\007\000\
\009\000\009\000\007\000\003\000\008\000\010\000\011\000\012\000\
\034\000\019\000\033\000\021\000\020\000\022\000\023\000\030\000\
\031\000\032\000\002\000\009\000\037\000\038\000\039\000\040\000\
\035\000\041\000\042\000\005\000\029\000\036\000"

let yycheck = "\008\001\
\009\001\001\000\011\001\013\001\014\001\015\001\004\001\005\001\
\004\001\005\001\007\001\006\001\000\000\001\001\003\001\001\001\
\010\001\004\001\001\001\003\001\005\001\003\001\003\001\002\001\
\002\001\002\001\000\000\006\000\004\001\004\001\004\001\003\001\
\012\001\001\001\004\001\004\001\020\000\028\000"

let yynames_const = "\
  EOF\000\
  LPAREN\000\
  RPAREN\000\
  SEMICOLON\000\
  CREATE\000\
  TABLE\000\
  REFERENCES\000\
  NOT\000\
  NULL\000\
  PRIMARY\000\
  KEY\000\
  VARCHAR\000\
  NUMBER\000\
  CHAR\000\
  "

let yynames_block = "\
  MAJIDENT\000\
  INT\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'tables) in
    Obj.repr(
# 11 "parser.mly"
             ( _1 )
# 127 "parser.ml"
               : Sql.sql_table list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'table) in
    Obj.repr(
# 14 "parser.mly"
        ( [_1] )
# 134 "parser.ml"
               : 'tables))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'table) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'tables) in
    Obj.repr(
# 15 "parser.mly"
               ( _1 :: _2 )
# 142 "parser.ml"
               : 'tables))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _5 = (Parsing.peek_val __caml_parser_env 1 : 'fields) in
    Obj.repr(
# 18 "parser.mly"
                                             ( Sql.Table (_3, _5) )
# 150 "parser.ml"
               : 'table))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'field) in
    Obj.repr(
# 21 "parser.mly"
        ( [_1] )
# 157 "parser.ml"
               : 'fields))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'field) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'fields) in
    Obj.repr(
# 22 "parser.mly"
                         ( _1 :: _3 )
# 165 "parser.ml"
               : 'fields))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : string) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'ftype) in
    Obj.repr(
# 25 "parser.mly"
                 ( Sql.Field (_1, _2, []) )
# 173 "parser.ml"
               : 'field))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'ftype) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'foptions) in
    Obj.repr(
# 26 "parser.mly"
                          ( Sql.Field (_1, _2, _3) )
# 182 "parser.ml"
               : 'field))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'foption) in
    Obj.repr(
# 29 "parser.mly"
          ( [_1] )
# 189 "parser.ml"
               : 'foptions))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'foption) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'foptions) in
    Obj.repr(
# 30 "parser.mly"
                   ( _1 :: _2 )
# 197 "parser.ml"
               : 'foptions))
; (fun __caml_parser_env ->
    Obj.repr(
# 33 "parser.mly"
           ( Sql.NotNull )
# 203 "parser.ml"
               : 'foption))
; (fun __caml_parser_env ->
    Obj.repr(
# 34 "parser.mly"
              ( Sql.PrimaryKey )
# 209 "parser.ml"
               : 'foption))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : string) in
    Obj.repr(
# 35 "parser.mly"
                                             ( Sql.References (_2, _4) )
# 217 "parser.ml"
               : 'foption))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 1 : int) in
    Obj.repr(
# 38 "parser.mly"
                            ( Sql.Varchar (_3) )
# 224 "parser.ml"
               : 'ftype))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 1 : int) in
    Obj.repr(
# 39 "parser.mly"
                           ( Sql.Number (_3) )
# 231 "parser.ml"
               : 'ftype))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 1 : int) in
    Obj.repr(
# 40 "parser.mly"
                         ( Sql.Char (_3) )
# 238 "parser.ml"
               : 'ftype))
(* Entry start *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
|]
let yytables =
  { Parsing.actions=yyact;
    Parsing.transl_const=yytransl_const;
    Parsing.transl_block=yytransl_block;
    Parsing.lhs=yylhs;
    Parsing.len=yylen;
    Parsing.defred=yydefred;
    Parsing.dgoto=yydgoto;
    Parsing.sindex=yysindex;
    Parsing.rindex=yyrindex;
    Parsing.gindex=yygindex;
    Parsing.tablesize=yytablesize;
    Parsing.table=yytable;
    Parsing.check=yycheck;
    Parsing.error_function=parse_error;
    Parsing.names_const=yynames_const;
    Parsing.names_block=yynames_block }
let start (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : Sql.sql_table list)
