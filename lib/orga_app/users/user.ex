defmodule OrgaApp.Users.User do
  use Ecto.Schema
  use Pow.Ecto.Schema
  use Pow.Extension.Ecto.Schema,
    extensions: [PowResetPassword, PowEmailConfirmation, PowInvitation]

  alias OrgaApp.Organizations.Organization

  schema "users" do
    belongs_to :organization, Organization

    pow_user_fields()

    timestamps()
  end

  def changeset(user_or_changeset, attrs) do
    user_or_changeset
    |> pow_changeset(attrs)
    |> pow_extension_changeset(attrs)
    |> Ecto.Changeset.assoc_constraint(:organization)
  end

   def invite_changeset(user_or_changeset, invited_by, attrs) do
    user_or_changeset
    |> pow_invite_changeset(invited_by, attrs)
    |> changeset_organization(invited_by)
  end

  defp changeset_organization(changeset, invited_by) do
    Ecto.Changeset.change(changeset, organization_id: invited_by.organization_id)
  end
end
