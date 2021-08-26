# thos file gets run before your tests
ExUnit.start()

# tell Ecto the Repo which will use the sandbox mode
Ecto.Adapters.SQL.Sandbox.mode(Auction.Repo, :manual)
