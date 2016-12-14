defmodule Blink do
  def blink() do
    for i <- 1..60 do
      IO.puts "Run time #{i}"
      # {_,{_, m, _}} = :os.timestamp |> :calendar.now_to_datetime
      
      #if rem(i, 2) == 0 do
       System.cmd("notify-send",["TODO","😃 😄 "])
       #end
      Process.sleep(60000)
       #:timer.sleep(60000)
    end

    blink() # Calling itself 
  end

end

# Run using the command given below
#  nohup elixir -r blinking.exs -e "Blink.blink" &
