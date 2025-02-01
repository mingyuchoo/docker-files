let () =
  Dream.run ~interface:"0.0.0.0" ~port:4000
    ( Dream.logger
    @@ Dream.router
         [ Dream.get "/" (fun _ -> Dream.html "Hello, world from OCaml!");
           Dream.get "/" (fun _ -> Dream.empty `Not_Found) ] )
