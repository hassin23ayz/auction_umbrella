#: From item_controller.ex we have come here
# this view module is responsible for rendering
# here helper functions can be added which will be later used by template eex
defmodule AuctionWeb.ItemView do
  use AuctionWeb, :view
  #: now we need to go to /templates directory and
  #: (1)create /templates/item folder
  #: (2)create /templates/item/index.html.eex folder

  def integer_to_currency(cents) do
    dollars_and_cents =
      cents
      |> Decimal.div(100)
      |> Decimal.round(2)
      "$#{dollars_and_cents}"
  end
end
