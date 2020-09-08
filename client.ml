open Lwt
open Cohttp
open Cohttp_lwt_unix

let reqBody =
  let uri = Uri.of_string "https://paper-api.alpaca.markets/v2/clock" in
  let headers = Header.init ()
    |> fun h -> Header.add_list h 
                [("APCA-API-KEY-ID","PKLDSENB0U8ST5KZI612"); 
                 ("APCA-API-SECRET-KEY","qEmsGIbj8WSBK3DLVDlwcB6KJ3JsLcndnuCHdLIu")]
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
