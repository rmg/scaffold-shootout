defmodule PhoenixBlog.Comment do
  use PhoenixBlog.Web, :model

  schema "comments" do
    field :body, :string
    belongs_to :author, PhoenixBlog.Author
    belongs_to :post, PhoenixBlog.Post

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:body])
    |> validate_required([:body])
  end
end
