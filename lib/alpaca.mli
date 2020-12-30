


type 'a res = ('a, Rresult.R.msg) Result.result
(** This library uses the {!Rresult.R.msg} conventions for returning
   errors rather than raising exceptions. *)

module Util : sig
  (** [member key d] returns the value wrapped in [Ok] associated with [key] otherwise [Error _] *) 
  val member : string -> Yaml.value -> Yaml.value option res

  val keys: Yaml.value -> string list res

  val to_list : Yaml.value -> Yaml.value list res 
  (** [to_list yml] will return a list of all values stored in a list-like Yaml.value  *)

  val map : (Yaml.value -> Yaml.value) -> Yaml.value -> Yaml.value res 
  (** [map f v] applies [f] to each element of [v] *)

  (* "Unboxing" functions *)
  val to_string : Yaml.value -> string res 
  val to_float : Yaml.value -> float res
  val to_bool : Yaml.value -> bool res 
end
