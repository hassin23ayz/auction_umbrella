defmodule AuctionWeb.ItemChannel do
  use Phoenix.Channel

  # channel instance = socket = this is the browser js client socket
  # 1 client socket connection creates 1 channel instance
  # phx channel is like a mqtt broker but per topic
  def join("item:" <> _item_id, _params, socket) do
    {:ok, socket}
  end

  # function handler which gets called when a message comes on this channel module's topic
  def handle_in("new_bid", params, socket) do  # pattern matches on the new_bid type message

    # Broadcast params msg with "new_bid" type tag to other channel instance(socket) that joined with this channel module's topic
    broadcast!(socket, "new_bid", params)
    {:noreply, socket}
  end

end

# usage : publishing message to this channel from iex console
# iex> AuctionWeb.Endpoint.broadcast("item:2", "new_bid", %{body: "hello from IEx"})
