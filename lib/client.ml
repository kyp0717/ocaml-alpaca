open Lwt
open Cohttp
open Cohttp_lwt_unix


let get_value key (yaml: Yaml.value) = match yaml with
  | `O assoc -> List.assoc_opt key assoc
  | _ -> None

let unbox opt = match opt with
  | Some x -> x
  | None -> "xxx"

let reqBody =
  let yaml = Yaml_unix.of_file_exn (Fpath.v "keys.paper.yaml") in
  let val1a = get_value "key" yaml in
  let val1b = unbox val1a in
  let val2a = get_value "secret" yaml in
  let val2b = get_value val2a in
  let uri = Uri.of_string "https://paper-api.alpaca.markets/v2/clock" in
  let headers = Header.init ()
    |> fun h -> Header.add_list h 
                [("APCA-API-KEY-ID", val1b); 
                 ("APCA-API-SECRET-KEY", val2b)]
  in
  Client.call ~headers `GET uri >>= fun (resp, body) ->
  let code = resp |> Response.status |> Code.code_of_status in
  Printf.printf "Response code: %d\n" code;
  Printf.printf "Headers: %s\n" (resp |> Response.headers |> Header.to_string);
  body |> Cohttp_lwt.Body.to_string >|= fun body ->
  Printf.printf "Body of length: %d\n" (String.length body);
  body

let () =
  let respBody = Lwt_main.run reqBody in
  print_endline (respBody)
