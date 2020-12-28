
#require "yaml"

#require "yaml.unix"

let get_value key (yaml: Yaml.value) = match yaml with
 | `O assoc -> List.assoc_opt key assoc
 | _ -> None

(* let destruct yaml:Yaml.value = match yaml with *)
(*   | *) 


let get_list  (yaml: Yaml.value) = match yaml with
 | `O assoc -> Some assoc
 | _ -> None

let unbox opt = match opt with
  | Some x -> x
  | None -> [("null", `String "No key found")]

let my_value (s:Yaml.value) = match s with
  | `String x -> x
  | _ -> " "

let () =
  let yaml = Yaml_unix.of_file_exn (Fpath.v "testyaml.yml") in
  let x1 = get_list yaml in
  let x2 = unbox x1 in
  let x3 = List.assoc "key" x2 in 
  let x4 = my_value x3 in
  print_endline (x4)

let yaml = Yaml_unix.of_file_exn (Fpath.v "testyaml.yml") 
let x1 = get_list yaml 
let x2 = unbox x1 
let x3 = List.assoc "key" x2  
let x4 = my_value x3 


_
