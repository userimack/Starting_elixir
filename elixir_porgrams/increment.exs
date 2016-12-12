defmodule Increment do

  def by_one([head | tail]) do
    [head + 1|by_one(tail)]
  end

  def by_one([]) do
    []
  end
end

IO.inspect Increment.by_one([1,2,3,4,5])
