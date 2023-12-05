defmodule Day2.PartTwo do
  alias Day2.Helpers, as: Day2Helpers

  def run(input) do
    input
    |> Helpers.parse()
    |> Enum.map(&Day2Helpers.prepare_input/1)
    |> Enum.reduce(0, fn {_id, colors_maps}, acc ->
      map = create_map(colors_maps, %{})

      acc +
        get_color_count(map, "red") * get_color_count(map, "green") * get_color_count(map, "blue")
    end)
  end

  defp create_map([], map), do: map

  defp create_map([head | tail], map) do
    map
    |> check_color(head, "red")
    |> check_color(head, "green")
    |> check_color(head, "blue")
    |> then(&create_map(tail, &1))
  end

  defp check_color(map, head_map, key) do
    head_value = Map.get(head_map, key, 1)

    if head_value > Map.get(map, key, 1) do
      Map.put(map, key, head_value)
    else
      map
    end
  end

  defp get_color_count(map, color), do: Map.get(map, color, 1)
end
