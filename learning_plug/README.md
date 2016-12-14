# LearningPlug

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `learning_plug` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:learning_plug, "~> 0.1.0"}]
    end
    ```

  2. Ensure `learning_plug` is started before your application:

    ```elixir
    def application do
      [applications: [:learning_plug]]
    end
    ```
# To test this application:
    iex -S mix
   
In the elixir shell type the following command:

    Plug.Adapters.Cowboy.http(LearningPlug, %{})
    
It will start a server at 127.0.0.1:4000 and start accepting connection on this url:
Input: 127.0.0.1:4000/Mahendra
Output: Hello, Mahendra
    
In the second module we have used logger to log our request it will print the requests made to the server. We can run the second module using thecommand:

    Plug.Adapters.Cowboy.http(MyPipeline, %{})

