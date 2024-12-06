defmodule StockAnalyst.StockPrices do
  use Ecto.Schema
  import Ecto.Changeset

  schema "stock_prices" do
    field :date, :date
    field :microsoft_open, :float
    field :google_open, :float
    field :apple_open, :float

    timestamps()
  end

  def changeset(stock_price, attrs) do
    stock_price
    |> cast(attrs, [:date, :microsoft_open, :google_open, :apple_open])
    |> validate_required([:date, :microsoft_open, :google_open, :apple_open])
  end
end
