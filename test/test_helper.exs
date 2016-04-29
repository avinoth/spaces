ExUnit.start

Mix.Task.run "ecto.create", ~w(-r Spaces.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r Spaces.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(Spaces.Repo)

