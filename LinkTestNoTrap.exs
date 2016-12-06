defmodule LinksTestNoTrap do
  def chain 0 do
    IO.puts "normal exit in the last link"
    exit(:noraml)
  end

  def chain n do
    IO.puts "create link in a chain no. #{n}"
    spawn_link(__MODULE__, :chain, [n-1])
    receive do
      msg -> IO.puts "#{n} received #{msg}"
    end
  end
end

