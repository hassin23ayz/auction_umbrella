# public interface to access database
defmodule Auction do
  # alias Auction.{Item, FakeRepo}    # multiple Alias in one line
  # @repo FakeRepo                    # denoting FaekRepo as a Module Attribute

  alias Auction.{Item, User, Password, Bid}
  @repo Auction.Repo
  def list_items do
    # call FakeRepo Module Passing Item as first argument
    @repo.all(Item)
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
  def update_item(%Auction.Item{} = item, updates) do
    item
    |> Item.changeset(updates)
    |> @repo.update()
  end

  def new_item() do
    Item.changeset(%Item{})
  end

  def edit_item(id) do
    get_item(id)
    |> Item.changeset()
  end

  # user section
  def get_user(id), do: @repo.get!(User, id)
  def new_user, do: User.changeset_with_password(%User{})

  def insert_user(params) do
    %User{}
    |> User.changeset_with_password(params)
    |> @repo.insert
  end

  def get_user_by_username_and_password(username, password) do
    with user when not is_nil(user) <- @repo.get_by(User, %{username: username}),
         true <- Password.verify_with_hash(password, user.hashed_password) do
      user
    else
      _ -> Password.dummy_verify # security reason do not let anyone know that this user is not listed
    end
  end

  # bid section
  def insert_bid(params) do
    %Bid{}
    |> Bid.changeset(params)
    |> @repo.insert()
  end

end

# usage example
# Auction.insert_item( %{title: "PS4", description: "costly", ends_at: DateTime.from_naive!(~N[2020-02-02 00:00:00], "Etc/UTC")} )
# first_item = Auction.list_items() |> Enum.at(0)
# Auction.update_item(first_item, %{title: "PS5"})
# Auction.list_items()
