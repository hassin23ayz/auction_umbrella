defmodule Auction.MixProject do
  use Mix.Project

  def project do
    [
      app: :auction,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases() # enable alias usage at mix command
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Auction.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
      # {:sibling_app_in_umbrella, in_umbrella: true}
      {:ecto_sql, "~> 3.6.0"},
      {:postgrex, "~> 0.15.0"},
      {:uuid, "~> 1.1.8"},
      {:comeonin, "~> 5.3.0"},
      {:pbkdf2_elixir, "~> 1.4.0"}
    ]
  end

  def aliases do
    # > mix test
    # test:  Alias name
    # [...]: list of commands
    [test: ["ecto.create --quiet", "ecto.migrate", "test"]]
  end
end
