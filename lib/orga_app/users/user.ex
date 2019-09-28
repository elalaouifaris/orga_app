defmodule OrgaApp.Users.User do
  use Ecto.Schema
  use Pow.Ecto.Schema

  alias OrgaApp.Users.User

  schema "users" do
    belongs_to :organization, Organization

    pow_user_fields()

    timestamps()
  end

  def changeset(user_or_changeset, attrs) do
    user_or_changeset
    |> pow_changeset(attrs)
    # |> pow_extension_changeset(attrs)
    |> Ecto.Changeset.assoc_constraint(:organization)
  end
end
