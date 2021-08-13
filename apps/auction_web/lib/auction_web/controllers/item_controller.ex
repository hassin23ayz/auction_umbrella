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

  def new(conn, _params) do
    item = Auction.new_item()
    render(conn, "new.html", item: item)
  end

  def create(conn, %{"item" => item_params}) do
    case Auction.insert_item(item_params) do
      {:ok, item} -> redirect(conn, to: Routes.item_path(conn, :show, item))
      {:error, item} -> render(conn, "new.html", item: item)
    end
  end

  def edit(conn, %{"id" => id}) do
    item = Auction.edit_item(id)
    render(conn, "edit.html", item: item)
  end

  def update(conn, %{"id" => id, "item" => item_params}) do
    item = Auction.get_item(id)
    case Auction.update_item(item, item_params) do
      {:ok, item} -> redirect(conn, to: Routes.item_path(conn, :show, item))
      {:error, item} -> render(conn, "edit.html", item: item)
    end
  end

end
