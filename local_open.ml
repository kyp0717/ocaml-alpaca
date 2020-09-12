
let google = Lwt_unix((List.hd addresses).ai_addr)


let google2 = let open Lwt_unix in (List.hd addresses).ai_addr

let google3 = (List.hd addresses).Lwt_unix.ai_addr
