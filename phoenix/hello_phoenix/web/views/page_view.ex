defmodule HelloPhoenix.PageView do
  use HelloPhoenix.Web, :view
  
  def render("index.json", %{pages: pages}) do
    %{data: render_many(pages, HelloPhoenix.PageView, "page.json")}
  end
  
  def render("show.json", %{page: page}) do
    %{data: render_one(page, HelloPhoenix.PageView, "page.json")}
  end

  def render("page.json", %{page: page}) do
    %{title: page.title}
  end

  def message do
    "Hello from the view!"
  end

  def handler_info(conn) do
    "Request Handled By: #{controller_module conn}.#{action_name conn}"   
  end

  def connection_keys(conn) do
    conn
    |> Map.from_struct()
    |> Map.keys()
  end
end
