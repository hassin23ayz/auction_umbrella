defmodule AuctionWeb.PageController do
  use AuctionWeb, :controller

  def index(conn, _params) do
    items = Auction.list_items()
    render(conn, "index.html", items: items) # pass the database as 3rd arg to view
  end
end
