defmodule PhoenixBlog.Repo.Migrations.CreateComment do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :body, :text
      add :author, references(:users, on_delete: :nothing)
      add :post, references(:posts, on_delete: :nothing)

      timestamps()
    end
    create index(:comments, [:author])
    create index(:comments, [:post])

  end
end
