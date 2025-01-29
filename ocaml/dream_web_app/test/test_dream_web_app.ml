(* test/test_dream_web_app.ml *)
open Alcotest

let test_example () =
  (* Your test code here *)
  ()

let () =
  run "Test Suite" [
    "Example Tests", [test_case "example test" `Quick test_example];
  ]