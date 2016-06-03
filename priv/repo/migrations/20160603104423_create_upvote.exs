defmodule Spaces.Repo.Migrations.CreateUpvote do
  use Ecto.Migration

  def change do
    create table(:upvotes) do
      add :user_id, references(:users, on_delete: :nothing)
      add :post_id, references(:posts, on_delete: :nothing)

      timestamps
    end
    create index(:upvotes, [:user_id])
    create index(:upvotes, [:post_id])

  end
end
