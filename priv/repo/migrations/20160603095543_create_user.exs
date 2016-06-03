defmodule Spaces.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :slack_name, :string
      add :slack_id, :string

      timestamps
    end

  end
end
