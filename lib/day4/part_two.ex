defmodule Day4.PartTwo do
  def run(input) do
    input =
      input
      |> Helpers.parse()
      |> Enum.map(fn str ->
        str
        |> String.split(": ")
        |> List.last()
        |> String.split(" | ")
        |> Enum.map(&to_list/1)
      end)
      |> Enum.with_index(fn element, index -> {index + 1, element} end)

    input
    |> do_run(build_initial_map(input))
    |> Enum.reduce(0, fn {_k, v}, acc -> acc + v end)
  end

  defp do_run([], new_map), do: new_map

  defp do_run([{index, [winning_numbers, your_numbers]} | tail], map) do
    common_values = get_common_values(winning_numbers, your_numbers)

    copies = Map.get(map, index, 1)

    new_map = add_copies(map, index + 1, index + Enum.count(common_values), copies)

    do_run(tail, new_map)
  end

  defp add_copies(map, index, ending_index, _copies) when index > ending_index, do: map

  defp add_copies(map, index, ending_index, copies) do
    map
    |> get_and_replace_recur(index, copies)
    |> add_copies(index + 1, ending_index, copies)
  end

  defp get_and_replace_recur(map, _index, 0), do: map

  defp get_and_replace_recur(map, index, copies) do
    map
    |> Map.get_and_update(index, fn
      current_value when is_nil(current_value) ->
        {current_value, 1}

      current_value ->
        {current_value, current_value + 1}
    end)
    |> then(fn {_, new_map} -> get_and_replace_recur(new_map, index, copies - 1) end)
  end

  defp build_initial_map(list) do
    count = Enum.count(list)

    do_build_initial_map(%{}, 1, count)
  end

  defp do_build_initial_map(map, index, count) when index > count, do: map

  defp do_build_initial_map(map, index, count) do
    map
    |> Map.put(index, 1)
    |> do_build_initial_map(index + 1, count)
  end

  defp to_list(str) do
    str
    |> String.split(" ")
    |> Enum.reject(&(&1 == ""))
  end

  defp get_common_values(list1, list2) do
    ms1 = MapSet.new(list1)
    ms2 = MapSet.new(list2)

    ms1
    |> MapSet.intersection(ms2)
    |> MapSet.to_list()
  end
end
