# public interface to access database
defmodule Auction do
  @moduledoc """
  Provides functions for interacting with the database layer of an Auction
  application.
  In order to keep database concerns separate from the rest of an
  application, these
  functions are provided. Any interaction you need to do with the database
  can be done
  from within these functions. See an individual function’s documentation for
  more
  information and usage examples (like
  `Auction.get_user_by_username_and_password/2`).
  """

  # ...
  # alias Auction.{Item, FakeRepo}    # multiple Alias in one line
  # @repo FakeRepo                    # denoting FaekRepo as a Module Attribute

  alias Auction.{Item, User, Password, Bid}
  @repo Auction.Repo

  import Ecto.Query

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

  # preloading the bids and the nested users
  # N+1 query problem prevention
  def get_item_with_bids(id) do
    id
    |> get_item()
    |> @repo.preload(bids: from(b in Bid, order_by: [desc: b.inserted_at]))
    # preloads the item's bids and the users of those bids
    |> @repo.preload(bids: [:user])
  end

  # user section
  def get_user(id), do: @repo.get!(User, id)
  def new_user, do: User.changeset_with_password(%User{})

  def insert_user(params) do
    %User{}
    |> User.changeset_with_password(params)
    |> @repo.insert
  end

  @doc """
  Retrieves a User from the database matching the provided username and password

  ## Return values

  Depending on what is found in the database, two different values could be
  returned:

    * a `Auction.User` struct: An `Auction.User` record was found that matched
      the `username` and `password` that was provided.
    * `false`: No `Auction.User` could be found with the provided `username`
      and `password`.

  You can then use the returned value to determine whether or not the User is
  authorized in your application. If an `Auction.User` is _not_ found based on
  `username`, the computational work of hashing a password is still done.

  ## Examples

      iex> insert_user(%{username: "geo", password: "example", password_confirmation: "example", email_address: "test@example.com"})
      ...> result = get_user_by_username_and_password("geo", "example")
      ...> match?(%Auction.User{username: "geo"}, result)
      true

      iex> get_user_by_username_and_password("no_user", "bad_password")
      false
  """
  def get_user_by_username_and_password(username, password) do
    with user when not is_nil(user) <- @repo.get_by(User, %{username: username}),
         true <- Password.verify_with_hash(password, user.hashed_password) do
      user
    else
      # security reason do not let anyone know that this user is not listed
      _ -> Password.dummy_verify()
    end
  end

  # bid section
  def insert_bid(params) do
    %Bid{}
    |> Bid.changeset(params)
    |> @repo.insert()
  end

  def new_bid, do: Bid.changeset(%Bid{})

  # this will use Ecto.Query
  def get_bids_for_user(user) do
    # first prepare the query
    # Bind the specific Database schema to a variable name
    query =
      from(b in Bid,
        # user id filtering
        where: b.user_id == ^user.id,
        # ordering
        order_by: [desc: :inserted_at],
        # preloading to avoid N+1 query problem
        preload: :item,
        # limit the result
        limit: 10
      )

    # pass the final query
    @repo.all(query)
  end
end

# usage example
# Auction.insert_item( %{title: "PS4", description: "costly", ends_at: DateTime.from_naive!(~N[2020-02-02 00:00:00], "Etc/UTC")} )
# first_item = Auction.list_items() |> Enum.at(0)
# Auction.update_item(first_item, %{title: "PS5"})
# Auction.list_items()
