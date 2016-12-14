defmodule Concat do
  def join(a, b) do
    IO.puts "***First Join***"
    a <> b
  end

  def join(a, b, sep \\ " ") do
    IO.puts "***Second Jon***"
    a <> sep <> b
  end
end
