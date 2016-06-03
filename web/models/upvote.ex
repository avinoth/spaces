defmodule Spaces.Upvote do
  use Spaces.Web, :model

  schema "upvotes" do
    belongs_to :user, Spaces.User
    belongs_to :post, Spaces.Post

    timestamps
  end

  @required_fields ~w()
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
