defmodule AuctionWeb.Api.ItemView do
  use AuctionWeb, :view

  def render("show.json", %{item: item}) do
    %{
      data: %{
        type: "item",
        id: item.id,
        title: item.title,
        description: item.description,
        ends_at: item.ends_at
      }
    } # this map data structure will automatically get
      # converted into valid JSON by Phx
  end
end
