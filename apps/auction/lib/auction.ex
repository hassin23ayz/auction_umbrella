defmodule Auction do                # public interface to access database
  alias Auction.{Item, FakeRepo}    # multiple Alias in one line

  @repo FakeRepo                    # denoting FaekRepo as a Module Attribute

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
end
