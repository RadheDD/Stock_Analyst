defmodule StockAnalyst.Repo.Migrations.CreateStockPrices do
  use Ecto.Migration

  def change do
    create table(:stock_prices) do
      add :date, :date
      add :microsoft_open, :float
      add :google_open, :float
      add :apple_open, :float

      timestamps()
    end
  end
end
