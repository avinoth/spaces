defmodule Spaces.Post do
  use Spaces.Web, :model

  schema "posts" do
    field :title, :string
    field :content, :string
    field :tags, {:array, :string}
    belongs_to :user, Spaces.User

    timestamps
  end

  @required_fields ~w(title content)
  @optional_fields ~w(user_id tags)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_length(:content, min: 2)
    |> validate_length(:content, max: 2000)
  end
end
