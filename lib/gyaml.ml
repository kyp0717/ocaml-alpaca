
#require "core";;
#require "yaml.unix";;
#require "yaml";;
let s_file = 
"key1: val1
key2: val2"

Core.String.split ~on:'\n' s_file

let make_tuple str = 
  let open Core.String in
  let lst = split ~on:':' str in
  match lst with
    | [] -> failwith "bad"
    | a::b -> (a, List.hd b |> strip)
    
    
let make_assoc_list lst =
  List.map lst make_tuple
  
make_assoc_list (Core.String.split ~on:'\n' s_file)


open Yaml
Yaml_unix.of_file Fpath.(v "alpaca.yml")

type _ gvalue = 
  | Yfloat : value -> float gvalue 
  | Ystring : value  -> string gvalue
  
(* type _ gexpr =
  | Gvalue : 'a gvalue -> 'a gexpr
   *)
  
let eval : type a. a gvalue -> a = function
  | Ystring s -> s
  | Yfloat f -> f

type empty = Empty

type _ gvalue = 
  | Vnull : Yaml.value ->   empty gvalue
  | Vfloat : Yaml.value -> float gvalue 
  | Vstring : Yaml.value  -> string gvalue

let val_to_gval : type a. a gvalue -> a  = function
 | Vnull (`Null ) -> Empty
 | Vfloat (`Float x ) -> x
 | Vstring (`String s ) -> s
 | _ -> failwith "xxx"
 
transform_to_gadt (Yaml_unix.of_file Fpath.(v "alpaca.yml"))

let get (type yv) (x: yv ygadt) : yv = 
  match x with
    | Yfloat f -> f
    | Ystring s -> s
