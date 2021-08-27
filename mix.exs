defmodule AuctionUmbrella.MixProject do
  use Mix.Project

  def project do
    [
      apps_path: "apps",
      version: "0.1.0",
      name: :auction,
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Dependencies listed here are available only for this
  # project and cannot be accessed from applications inside
  # the apps folder.
  #
  # Run "mix help deps" for examples and options.
  defp deps do
    [
      # exdoc is not part of the standard library
      # dev: true means this dependency is not used in production
      {:ex_doc, "~> 0.19", dev: true, runtime: false}
    ]
  end
end
