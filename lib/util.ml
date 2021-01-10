open Rresult

let get_value key = function 
  | `O assoc -> Ok (List.assoc_opt key assoc)
  | _ -> Error (`Msg "Expecting a Yaml.value of `O")



let get_keys = function 
  | `O assoc -> Ok (List.map (fun (key, _) -> key) assoc)                                                     
  | _ -> Error (`Msg "Expecting a Yaml.value of `O")

let to_list = function 
  | `O assoc -> Ok (List.map (fun (_, v) -> v) assoc)                                                     
  | _ -> Error (`Msg "Expecting a Yaml.value of `O")

  
let get_string = function
    | None -> failwith "bad"
    | Some v -> match v with
                | `String x -> x
                | _ -> failwith "bad xxxx"


let get_string_opt = function
  | Ok (x) -> x
  | Error _ -> None


let to_string = function
  | `String a -> Ok a
  | _ -> Error (`Msg "Expecting a Yaml.value of `String")

let to_bool = function
  | `Bool a -> Ok a
  | _ -> Error (`Msg "Expecting a Yaml.value of `Bool")

let to_float = function
  | `Float a -> Ok a
  | _ -> Error (`Msg "Expecting a Yaml.value of `Float")

let map f = function
  | `A lst -> Ok ( `A (List.map f lst) )
  | _ -> Error (`Msg "Expecting a Yaml.value of `A")
  
