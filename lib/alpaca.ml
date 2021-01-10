module Util = Util
type 'a res = ('a, Rresult.R.msg) Result.result

open Rresult
open R.Infix


open Lwt
open Cohttp
open Cohttp_lwt_unix

type access_info = {
  urltrade : string;
  urldata : string;
  urlsocket: string;
  key : string;
  secret: string;
} [@@deriving yaml]

let (alpaca_secret, alpaca_key) = 
  let yaml = Yaml_unix.of_file_exn (Fpath.v "keys.paper.yaml") in
  let key = yaml |> get_value "key" |> get_string_opt |> get_string in 
  let secret = yaml |> get_value "secret" |> get_string_opt |> get_string in
  (secret, key)

(* 
let alpaca_key =
  let yaml = Yaml_unix.of_file_exn (Fpath.v "keys.paper.yaml") in
  get_value "key" yaml |> unbox *)

let headers = Header.init ()
  |> fun h -> Header.add_list h 
              [("APCA-API-KEY-ID", val1b); 
               ("APCA-API-SECRET-KEY", val2b)]

let req_alpaca_time =
  let uri = Uri.of_string "https://paper-api.alpaca.markets/v2/clock" in
  Client.call ~headers `GET uri 
  >>= fun (resp, body) ->
  let code = resp |> Response.status |> Code.code_of_status in
  Printf.printf "Response code: %d\n" code;
  Printf.printf "Headers: %s\n" (resp |> Response.headers |> Header.to_string);
  body |> Cohttp_lwt.Body.to_string >|= fun body ->
  Printf.printf "Body of length: %d\n" (String.length body);
  body

let () =
  let respBody = Lwt_main.run reqBody in
  print_endline (respBody)
