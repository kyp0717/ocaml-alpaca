open Lwt
open Cohttp
open Cohttp_lwt_unix


let get_value key (yaml: Yaml.value) = match yaml with
  | `O assoc -> List.assoc_opt key assoc
  | _ -> None

let unbox opt = match opt with
  | Some x -> x
  | None -> "xxx"

let () =
  let yaml = Yaml_unix.of_file_exn (Fpath.v "keys.paper.yaml") in
  let val1a = get_value "key" yaml in
  (* let val1b = unbox val1a in *)
  print_endline (val1a)
