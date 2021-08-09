defmodule Auction.Item do
  use Ecto.Schema
  import Ecto.Changeset   # importing discards the need of using Ecto.Changeset call before each function call

  schema "items" do
    field(:title, :string)
    field(:description, :string)
    field(:ends_at, :utc_datetime)
    timestamps()
  end

  defp validate(:ends_at, ends_at_date) do
    case DateTime.compare(ends_at_date, DateTime.utc_now()) do
      :lt -> [ends_at: "ends_at cannot be in the past"]
      _ -> []
    end
  end

  # arg1: item : the structure type data that need/has changes , is to be validated by changeset
  # arg2: params \\ %{} : a map off attributes to update with the default being an empty map
  def changeset(item, params \\ %{}) do
    item
    |> cast(params, [:title, :description, :ends_at]) # cast checks passed params with the keys in the List
    |> validate_required(:title)                      # tells that this changeset requires the title attribute to be present in the item
    |> validate_length(:title, min: 3)                # tells that the title length to be of atleast 3
    |> validate_length(:description, max: 200)        # tells that the decription length has to be under 200
    |> validate_change(:ends_at, &validate/2)         # validates timestamp
  end

end
