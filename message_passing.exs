defmodule Example do
    def listen do
      receive do
        {:ok, "hello"} -> IO.puts "world"
      end

      # listen
    end
end

