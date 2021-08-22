defmodule AuctionWeb.BidController do
  use AuctionWeb, :controller
  plug :require_logged_in_user #1. User logged in gets checked at first

  def create(conn, %{"bid" => %{"amount" => amount}, "item_id" => item_id}) do
    user_id = conn.assigns.current_user.id

    case Auction.insert_bid(%{amount: amount, item_id: item_id, user_id: user_id}) do
      {:ok, bid} ->  # 2. if bid gets entered into DB successfully then item is shown
        # construct html page
        html = Phoenix.View.render_to_string(AuctionWeb.BidView,
                                            "bid.html",
                                            bid: bid,
                                            username: conn.assigns.current_user.username)
        # broadcast to all the other clients(/channel sockets )
        AuctionWeb.Endpoint.broadcast("item:#{item_id}", "new_bid", %{body: html})
        # update frontend
        redirect(conn, to: Routes.item_path(conn, :show, bid.item_id))

      {:error, bid} -> # 3. if bid fails to enter DB then we go into form submission, at form submission user fills up bid and from there we again come to this create function and retry to enter into DB
        item = Auction.get_item(item_id)
        render(conn, AuctionWeb.ItemView, "show.html", item: item, bid: bid)
    end
  end

  # uses pattern matching to detect there is no current user logged in
  defp require_logged_in_user(%{assigns: %{current_user: nil}} = conn, _opts) do
    conn
    |> put_flash(:error, "Nice try, friend. You must be logged in to bid.")
    |> redirect(to: Routes.item_path(conn, :index))
    |> halt()
  end

  # uses pattern matching to detetc there is a current user logged in
  defp require_logged_in_user(conn, _opts), do: conn
end
