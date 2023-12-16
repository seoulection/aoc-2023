defmodule Day9.PartTwo do
  def run(input) do
    input
    |> prepare_input()
    |> Enum.reduce([], fn list, acc ->
      initial_acc = []
      initial_map = %{0 => list}
      initial_index = 1

      acc ++ [find_history_value(list, initial_map, initial_acc, initial_index)]
    end)
    |> Enum.sum()
  end

  defp find_history_value([_head | []], map, acc, index) do
    if Enum.all?(acc, &(&1 == 0)) do
      calculate_value(map)
    else
      result = Enum.reverse(acc)

      find_history_value(result, Map.put(map, index, result), [], index + 1)
    end
  end

  defp find_history_value([head | [tail_h | _] = tail], map, acc, index),
    do: find_history_value(tail, map, [tail_h - head | acc], index)

  defp calculate_value(map) do
    map
    |> Map.keys()
    |> Enum.reverse()
    |> Enum.reduce(0, fn key, acc ->
      [first | _] = Map.get(map, key)

      first - acc
    end)
  end

  defp prepare_input(input) do
    input
    |> Helpers.parse()
    |> Enum.map(fn str ->
      str
      |> String.split(" ")
      |> Enum.map(fn char ->
        char
        |> Integer.parse()
        |> then(fn {num, _} -> num end)
      end)
    end)
  end
end
