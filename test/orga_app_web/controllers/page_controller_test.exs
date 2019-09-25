defmodule OrgaAppWeb.PageControllerTest do
  use OrgaAppWeb.ConnCase

  alias OrgaApp.Users.User
  
  setup %{conn: conn} do
    user = %User{email: "test@example.com"}
    conn = Pow.Plug.assign_current_user(conn, user, otp_app: :orga_app)

    {:ok, conn: conn}
  end

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Welcome to Phoenix!"
  end
end
