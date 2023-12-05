defmodule Day2.Helpers do
  def prepare_input(input_str) do
    [game | [colors]] = String.split(input_str, ": ")

    {id, _} =
      game
      |> String.split(" ")
      |> List.last()
      |> Integer.parse()

    colors_maps =
      colors
      |> String.split("; ")
      |> Enum.map(fn str ->
        str
        |> String.split(", ")
        |> Enum.reduce(%{}, fn hi, acc ->
          [amount_str, color_str] = String.split(hi, " ")

          {amount, _} = Integer.parse(amount_str)

          Map.put(acc, color_str, amount)
        end)
      end)

    {id, colors_maps}
  end
end
