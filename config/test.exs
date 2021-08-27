use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :auction_web, AuctionWeb.Endpoint,
  http: [port: 4002],
  server: false

config :auction, Auction.Repo,
  # apps/auction/test/auction_test.ex
  database: "auction_test",
  username: "auction",
  password: "auction",
  hostname: "localhost",
  port: "5432",
  # Sandbox is a pool of database connections <--> Tests use these connections
  pool: Ecto.Adapters.SQL.Sandbox

config :logger, level: :info # disables debug level bug
