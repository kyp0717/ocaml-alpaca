
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


let yaml = Yaml_unix.of_file_exn (Fpath.v "keys.paper.yaml") 

let unbox opt = match opt with
  | Some x -> x
  | None -> print_endline "No Value"

let () =
  let yaml = Yaml_unix.of_file_exn (Fpath.v "keys.paper.yaml") in
  let val1a = get_value "key" yaml in
  (* let val1b = unbox val1a in *)
  print_endline (val1a)

let l = get_list yaml

let l2 = unbox l
