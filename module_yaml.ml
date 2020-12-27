
#require "yaml"

module type YAMLVAL = sig
  type t
  val extract: Yaml.value -> t
end



module Yaml_Assoc : YAMLVAL with type t=((string*Yaml.value) list option) = struct
  type t =   ((string * Yaml.value) list option)
  let extract (a:Yaml.value) =  match a with
     | `O assoc -> Some assoc 
     | _ -> None
end

(* module ALPACA_API : YAMLVAL = Yaml_Assoc *) 


module type X_int = sig
  val x: int
end

