


type 'a res = ('a, Rresult.R.msg) Result.result
(** This library uses the {!Rresult.R.msg} conventions for returning
   errors rather than raising exceptions. *)

module Util : sig
  (** [member key d] returns the value wrapped in [Ok] associated with [key] otherwise [Error _] *) 
  val member : string -> Yaml.value -> Yaml.value option res
end
