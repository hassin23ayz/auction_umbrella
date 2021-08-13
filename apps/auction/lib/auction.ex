defmodule Auction do                # public interface to access database
  #alias Auction.{Item, FakeRepo}    # multiple Alias in one line
  #@repo FakeRepo                    # denoting FaekRepo as a Module Attribute

  alias Auction.Item
  @repo Auction.Repo
  def list_items do
    @repo.all(Item)                 # call FakeRepo Module Passing Item as first argument
                                    # It lets the database know which table(set of data) you are requesting
                                    # Item is here like telling more of a type
  end

  def get_item(id) do
    @repo.get!(Item, id)
  end

  def get_item_by(attrs) do
    @repo.get_by(Item, attrs)
  end

  def insert_item(attrs) do
    %Item{}
    |> Item.changeset(attrs)
    |> @repo.insert()
    end

  def delete_item(%Auction.Item{} = item), do: @repo.delete(item)

  # Pattern-matches on the first parameter to ensure that you’re actually receiving an Auction.Item struct
  def update_item( %Auction.Item{} = item, change_of_item) do
    item
    |> Item.changeset(change_of_item)
    |> @repo.update!()
  end

  def new_item() do
    Item.changeset( %Item{} )
  end

end

# usage example
# Auction.insert_item( %{title: "PS4", description: "costly", ends_at: DateTime.from_naive!(~N[2020-02-02 00:00:00], "Etc/UTC")} )
# first_item = Auction.list_items() |> Enum.at(0)
# Auction.update_item(first_item, %{title: "PS5"})
# Auction.list_items()
