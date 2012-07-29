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
