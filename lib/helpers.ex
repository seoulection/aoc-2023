defmodule Helpers do
  def parse(input) do
    input
    |> String.trim_trailing()
    |> String.split("\n")
  end
end
