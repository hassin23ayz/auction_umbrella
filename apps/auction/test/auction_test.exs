defmodule AuctionTest do
  use ExUnit.Case
  alias Auction.{Repo, Item}
  doctest Auction

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
  end

  # group of similar Tests
  describe "list_items/0" do
    # this setup will run first for each test in the setup block
    setup do
      {:ok, item1} = Repo.insert(%Item{title: "Item 1"})
      {:ok, item2} = Repo.insert(%Item{title: "Item 2"})
      {:ok, item3} = Repo.insert(%Item{title: "Item 3"})
      %{items: [item1, item2, item3]}
    end

    test "returns all Items in the database", %{items: items} do
      assert items == Auction.list_items()
    end
  end
end
