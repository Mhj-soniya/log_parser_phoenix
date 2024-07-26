defmodule LogParser.Parser.Log do
  use Ecto.Schema
  import Ecto.Changeset

  schema "logs" do
    field :timestamp, :naive_datetime
    field :path, :string
    field :host, :string
    field :ip, :string
    field :method, :string
    field :http_version, :string
    field :response_status, :integer
    field :response_size, :integer
    field :referer, :string
    field :user_agent, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(log, attrs) do
    log
    |> cast(attrs, [:host, :ip, :timestamp, :method, :path, :http_version, :response_status, :response_size, :referer, :user_agent])
    |> validate_required([:host, :ip, :timestamp, :method, :path, :http_version, :response_status, :response_size, :referer, :user_agent])
  end
end
