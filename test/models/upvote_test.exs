defmodule Spaces.UpvoteTest do
  use Spaces.ModelCase

  alias Spaces.Upvote

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Upvote.changeset(%Upvote{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Upvote.changeset(%Upvote{}, @invalid_attrs)
    refute changeset.valid?
  end
end
