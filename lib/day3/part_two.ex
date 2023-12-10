defmodule Day3.PartTwo do
  # String.match?(_, ~r/^[0-9]$/)

  # def run(input) do
  #   input_map =
  #     input
  #     |> Helpers.parse()
  #     |> Enum.with_index()
  #     |> Enum.reduce(%{}, fn {str, index}, acc ->
  #       str
  #       |> String.split("", trim: true)
  #       |> Enum.with_index()
  #       |> then(&Map.put(acc, index, &1))
  #     end)
  #     |> IO.inspect(label: "INPUT MAP")

  #   ending_index =
  #     input_map
  #     |> Map.keys()
  #     |> List.last()

  #   Enum.reduce(input_map, [], fn {k, v}, acc ->
  #     coordinates = find_valid_coordinates(v, input_map, k, ending_index, MapSet.new())

  #     [coordinates | acc]
  #   end)
  # end

  # defp find_valid_coordinates([], _, _, _, coordinates), do: coordinates

  # defp find_valid_coordinates([{"*", 0} | tail], input_map, 0 = index, ending_index, coordinates) do
  #   input_map
  #   |> scan_top_left(coordinates)
  #   |> then(&find_valid_coordinates(tail, input_map, index, ending_index, &1))
  # end

  # defp find_valid_coordinates([{_, _} | tail], input_map, index, ending_index, coordinates),
  #   do: find_valid_coordinates(tail, input_map, index, ending_index, coordinates)

  # defp scan_top_left(input_map, coordinates) do
  # end

  # defp scan_by_indices(input_map, i1, i2) do
  # end

  # defp get_value_by_indices(input_map, i1, i2) do
  #   input_map
  #   |> Map.get(i1)
  #   |> Enum.filter(fn {_, index} -> index == i2 end)
  # end
end
