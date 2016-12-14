defmodule Table do
  def ping do
    receive do 
      {from, :ping} ->
        IO.puts 'Ping process reached, going to respond with :pong'
        send from, {self(), :pong}
        #:ping -> IO.puts('received ping')
    end
    ping # to call itself so that the process continues executing
  end

  def start do
    spawn(__MODULE__, :ping, [])
  end
end

