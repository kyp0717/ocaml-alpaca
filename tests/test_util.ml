[@@@part "0"]


let yaml = Alcotest.testable Yaml.pp Yaml.equal

let pp_error ppf (`Msg x) = Format.pp_print_string ppf x

let error = Alcotest.testable pp_error ( = )

[@@@part "1"]

let test_member () =
  let ok_input = `O [ ("author", `String "Alice") ] in
  let ok_output = Ok (Some (`String "Alice") ) in
  let err_input = `String "Test_Error" in
  let err_output = Error (`Msg "Expecting a Yaml.value of `O") in
  Alcotest.(check (result (option yaml) error)) "success" ok_output (Alpaca.Util.member "author" ok_input);
  Alcotest.(check (result (option yaml) error))  "fail" err_output (Alpaca.Util.member "author" err_input)

[@@@part "2"]
