defmodule LousyCalculator do
  @spec add(number, number) :: {number, String.t}
  def add(x, y), do: {x + y, "Do you really need a calculator to do this? :D"}

    @spec multiply(number, number) :: {number, String.t}
    def multiply(x, y), do: {x * y, "Jeez, come on!"}
end

