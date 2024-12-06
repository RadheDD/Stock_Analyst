defmodule StockAnalyst.Repo do
  use Ecto.Repo,
    otp_app: :stock_analyst,
    adapter: Ecto.Adapters.Postgres
end
