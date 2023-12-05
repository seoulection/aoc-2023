defmodule Day2.PartOne do
  alias Day2.Helpers, as: Day2Helpers

  def run(input) do
    input
    |> Helpers.parse()
    |> Enum.map(&Day2Helpers.prepare_input/1)
    |> Enum.reduce(0, fn {id, colors_maps}, acc ->
      if possible_game?(colors_maps) do
        acc + id
      else
        acc
      end
    end)
  end

  defp possible_game?([]), do: true

  defp possible_game?([head | tail]) do
    if get_color_count(head, "red") <= 12 && get_color_count(head, "green") <= 13 &&
         get_color_count(head, "blue") <= 14 do
      possible_game?(tail)
    else
      false
    end
  end

  defp get_color_count(map, color), do: Map.get(map, color, 0)
end
