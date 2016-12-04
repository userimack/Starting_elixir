# my_case.exs
defmodule MyCase do
  def do_something(tuple) do
    case tuple do
      {:ok, value} ->
        "The status was :ok!"
     {:nope, value}->
       "Nope nope"
      _->
      "You passed in something else."
    end
  end

end
