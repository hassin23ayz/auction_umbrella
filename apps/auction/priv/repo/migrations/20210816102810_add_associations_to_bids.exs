defmodule Auction.Repo.Migrations.AddAssociationsToBids do
  use Ecto.Migration

  def change do
    alter table(:bids) do               # by alter add/modify/remove columns of :bids table
                                        # adding 2 columns to track Associations
      add :item_id, references(:items)  # new column added, references ensures that item_id = an actual item id
      add :user_id, references(:users)  # new column added, references ensures that user_id = an actual user id
    end
                                        # it’s good to create a table index on columns that you’ll be searching on
    create index(:bids, [:item_id])     # search for bids on a specific item
    create index(:bids, [:user_id])     # search for bids on a specific user
    create index(:bids, [:item_id, :user_id]) # search for bids on a specific user+item
  end

end

# The Ecto Schemas of the Application needs to know about the Associations
