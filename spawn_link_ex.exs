# spawn_link_ex.exs

spawn_link fn -> raise "oops" end

receive do
  :hello -> "let's wait until the process fails"
end

