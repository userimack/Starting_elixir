defmodule Bidirectional do
  def leaf name do
    receive do
      msg -> IO.puts "#{name} received #{msg}"
    end
  end

  def node name do
    spawn_link __MODULE__, :leaf, ["node: #{name} first leaf"]
    spawn_link __MODULE__, :leaf, ["node #{name} second leaf"]
    spawn_link __MODULE__, :leaf, ["node #{name} third leaf" ]
    receive do
      msg -> IO.puts "#{name} received #{msg}"
    end
  end

  def kernel do
    spawn_link __MODULE__, :node, ["first node"]
    spawn_link __MODULE__, :node, ["second node"]
    receive do
      msg -> IO.puts "kerne; received #{msg}"
    end
  end

  def create_graph do
    spawn_link __MODULE__, :kernel, []
  end
end

