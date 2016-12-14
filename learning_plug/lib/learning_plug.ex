defmodule LearningPlug do
  # The Plug.Conn module gives us the main function
  # we will use to work with our connection, which is
  # a %Plug.Conn{} struct, also defined in this module
  import Plug.Conn

  def init(opts) do
    # Here we just add a new entry in the opts map, that we can use
    # in the call/2 function
    Map.put(opts, :my_option, "Hello")
  end

  def call(%Plug.Conn{request_path: "/" <> name} = conn, opts) do
    # And we send a response back, with a status code and a body
    send_resp(conn, 200, "Hello, #{name}")
  end
end
