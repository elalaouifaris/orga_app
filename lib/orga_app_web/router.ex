defmodule OrgaAppWeb.Router do
  use OrgaAppWeb, :router
  use Pow.Phoenix.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :protected do
    plug Pow.Plug.RequireAuthenticated,
      error_handler: OrgaAppWeb.AuthErrorHandler
  end

   pipeline :not_authenticated do
    plug Pow.Plug.RequireNotAuthenticated,
      error_handler: OrgaAppWeb.AuthErrorHandler
  end

  scope "/", OrgaAppWeb do
    pipe_through [:browser, :not_authenticated]

    get "/signup", RegistrationController, :new, as: :signup
    post "/signup", RegistrationController, :create, as: :signup
    get "/login", SessionController, :new, as: :login
    post "/login", SessionController, :create, as: :login
  end

  scope "/", OrgaAppWeb do
    pipe_through [:browser, :protected]

    delete "/logout", SessionController, :delete, as: :logout
    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", OrgaAppWeb do
  #   pipe_through :api
  # end
end
