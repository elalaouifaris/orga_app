defmodule OrgaApp.Organizations.Organization do
  use Ecto.Schema
  import Ecto.Changeset
  alias OrgaApp.Users.User

  schema "organizations" do
    field :name, :string
    has_many :users, User, on_delete: :delete_all

    timestamps()
  end

  @doc false
  def changeset(organization, attrs) do
    organization
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> changeset_users
  end

  defp changeset_users(changeset) do
    case Ecto.get_meta(changeset.data, :state) do
      :built -> cast_assoc(changeset, :users, required: true)
      _any -> changeset
    end
  end
end
