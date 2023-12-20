defmodule Helpers do
  def parse(input) do
    input
    |> String.trim_trailing()
    |> String.split("\n")
  end

  def transpose(list) do
    list
    |> List.zip()
    |> Enum.map(&Tuple.to_list/1)
  end
end
