defmodule Spaces.UserTest do
  use Spaces.ModelCase

  alias Spaces.User

  @valid_attrs %{name: "some content", slack_id: "some content", slack_name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
