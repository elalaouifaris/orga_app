defmodule OrgaAppWeb.OrganizationController do
  use OrgaAppWeb, :controller

  alias OrgaApp.{Organizations.Organization, Repo}

  def new(conn, _params) do
    changeset = Organization.changeset(%Organization{}, %{})

    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"organization" => user_params}) do
    %Organization{}
    |> Organization.changeset(user_params)
    |> Repo.insert()
    |> case do
      {:ok, organization} ->
        conn
        |> auth_user(organization.users)
        |> put_flash(:info, "Welcome!")
        |> redirect(to: Routes.page_path(conn, :index))

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end  

  defp auth_user(conn, [user]) do
    config = Pow.Plug.fetch_config(conn)

    Pow.Plug.get_plug(config).do_create(conn, user, config)
  end
end