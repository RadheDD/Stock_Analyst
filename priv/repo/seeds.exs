# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     StockAnalyst.Repo.insert!(%StockAnalyst.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias StockAnalyst.Repo
alias StockAnalyst.StockPrices

require Logger

# Path to your CSV file
csv_path = "priv/repo/Stock_Open_Prices.csv"

# Read and process the CSV file
csv_path
|> File.stream!()
|> Stream.drop(1) # Skip the header row
|> Stream.map(fn line ->
  [date, microsoft_open, google_open, apple_open] =
    line
    |> String.trim()
    |> String.split(",")

  %{
    date: Date.from_iso8601!(date),
    microsoft_open: String.to_float(microsoft_open),
    google_open: String.to_float(google_open),
    apple_open: String.to_float(apple_open)
  }
end)
|> Enum.each(fn stock_data ->
  case Repo.insert(%StockPrices{} |> StockPrices.changeset(stock_data)) do
    {:ok, _record} -> Logger.info("Inserted: #{inspect(stock_data)}")
    {:error, changeset} -> Logger.error("Failed to insert: #{inspect(changeset)}")
  end
end)
