defmodule Auction.Bid do
  use Ecto.Schema
  import Ecto.Changeset

  schema "bids" do
    field(:amount, :integer)
                                   # we will define belongs_to association
    belongs_to :item, Auction.Item # :item is the name of the association, next is the module name where the corresponding schema is defined
    belongs_to :user, Auction.User # :user is the name of the association, next is the module name where the corresponding schema is defined
    timestamps()
  end

  # Every insert and update op based on correct association can be verified using Ecto.Changeset
  def changeset(bid, params \\ %{}) do
    bid
    |> cast(params, [:amount, :user_id, :item_id])      # cast checks passed params with the keys in the List
    |> validate_required([:amount, :user_id, :item_id]) # tells that this changeset requires these attributes to be already present in the bid
    |> assoc_constraint(:item)                          # checks the association
    |> assoc_constraint(:user)                          # checks the association
  end

end
