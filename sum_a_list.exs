defmodule Math do
  def sum_list(a, b \\ 0)
  def sum_list([head | tail], accumulator) do
    sum_list(tail, head + accumulator)
  end

  def sum_list([], accumulator) do
    accumulator
  end
end

IO.puts "First #{Math.sum_list([1,2,3])}"
IO.puts "Second #{Math.sum_list([1,2,3,4],0)}"

IO.puts "Third #{Math.sum_list([1,2,3,4,5,6,7,8,9])}"
