#: from router.ex we have come here
#: Here in controller layer Actions of HTTP req[verb/path] takes place
#: From this layer we talk to buisness domain code aka Model
defmodule AuctionWeb.ItemController do
  use AuctionWeb, :controller

  #: conn is a struct which holds a ton of data about the request
  #: _params has the request parameters (unused)
  def index(conn, _params) do
    # link up with Model Layer happens here
    items = Auction.list_items()
    render(conn, "index.html", items: items) # pass the database as 3rd arg to view
    #: From here we go to item_view.ex
  end

  def show(conn, %{"id"=> id}) do
    item = Auction.get_item(id)
    render(conn, "show.html", item: item)
  end

end