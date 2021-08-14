#: responsible for dispatching verb/path to controllers
#: allows us to scope functionality, e.g some pages may require authentication

defmodule AuctionWeb.Router do
  use AuctionWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session         # session can be read from / written to
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  #: this grp of routes will attempt to match all routes beginning with /
  scope "/", AuctionWeb do
    pipe_through :browser #: handles some house keeping for all common browser style requests

    #: from endpoint.ex we have come here , Adding a new Route
    #: HTTP requests [verb/path] matching happens here
    #: HTTP_method   Route,  Controller_module   Handler_CRUD_action_functions list
    get "/", PageController, :index

    # get    "/items",          ItemController, :index
    # get    "/items/new",      ItemController, :new
    # post   "/items",          ItemController, :create
    # get    "/items/:id",      ItemController, :show
    # get    "/items/:id/edit", ItemController, :edit
    # patch  "/items/:id",      ItemController, :update
    # put    "/items/:id",      ItemController, :update
    # delete "/items/:id",      ItemController, :delete

    # All the boilerplate from above is created by the following line
    resources "/items", ItemController, only: [
      :index,  # url usage http://localhost:4000/items/
      :show,   # [is called from :index :create]
      :new,    # url usage http://localhost:4000/items/new
      :create, # [is called from :new]
      :edit,   # url usage http://localhost:4000/items/3/edit
      :update  # [is called from :edit]
    ]

    resources "/users", UserController, only: [
      :new,    # url usage http://localhost:4000/users/new      [1]
      :create, # is called from :new (new.html.eex)             [2]
      :show    # is called from :create (user_controller.ex)    [3]
    ]

    # user session related
    get    "/login",  SessionController, :new     # url usage http://localhost:4000/login
    post   "/login",  SessionController, :create  # is called from :new (new.html.eex)
    delete "/logout", SessionController, :delete

  end

  # Other scopes may use custom stacks.
  # scope "/api", AuctionWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: AuctionWeb.Telemetry
    end
  end
end
