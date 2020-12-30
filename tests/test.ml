
let member = 
  [ "member", `Quick, Test_util.test_member ]

let keys = 
  [ "keys", `Quick, Test_util.test_keys ]

let map = 
  [ "map", `Quick, Test_util.test_map]

let to_list= 
  [ "to_list", `Quick, Test_util.test_to_list]

let to_string= 
  [ "to_string", `Quick, Test_util.test_to_string]

let to_bool= 
  [ "to_bool", `Quick, Test_util.test_to_bool]

let to_float= 
  [ "to_float", `Quick, Test_util.test_to_float]


let tests = [
    "member", member;
    "keys", keys;
    "to_list", to_list;
    "to_string", to_string;
    "to_bool", to_bool;
    "to_float", to_float;
    "map", map;
  ]

(* Run it *)
let () =
  Junit_alcotest.run_and_report "Yaml" tests |>
  fun (r,e) ->
  Junit.(to_file (make [r]) "alcotest-junit.xml");
  e ()
