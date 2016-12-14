defmodule Table do
  def ping do
    receive do
      {from, :ping} ->
        IO.puts 'ping process reached, going to respond with :pong'
        :timer.sleep(1000)
        send from, {self(), :pong}
    end
    ping
  end

  def pong do #1
    receive do
      {from, :pong} ->
        IO.puts 'pong process reached, going to respond with :ping'
        :timer.sleep(1000)
        send from, {self(), :ping}
    end
    pong
  end

  def start do
    ping_pid = spawn __MODULE__, :ping, []
    pong_pid = spawn __MODULE__, :pong, []
    {ping_pid, pong_pid}
  end
end

