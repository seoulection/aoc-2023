defmodule Day11.PartOne do
  def run(input) do
    # reversal after expansion puts universe correctly on a cartesian plane

    map =
      input
      |> Helpers.parse()
      |> expand_horizontal()
      |> expand_vertical()
      |> Enum.reverse()
      |> create_map()

    keys =
      map
      |> Map.keys()
      |> Enum.sort()

    last_key = List.last(keys)

    Enum.reduce(keys, 0, fn key, acc ->
      if key == last_key do
        acc
      else
        point = Map.get(map, key)
        acc + count_for_point(point, map, key + 1, last_key, 0)
      end
    end)
  end

  defp count_for_point(point, map, key, last_key, acc) when key == last_key,
    do: acc + manhattan_distance(point, Map.get(map, key))

  defp count_for_point(point, map, key, last_key, acc) do
    other_point = Map.get(map, key)
    new_acc = acc + manhattan_distance(point, other_point)

    count_for_point(point, map, key + 1, last_key, new_acc)
  end

  defp create_map(list) do
    list
    |> Enum.with_index()
    |> Enum.reduce({%{}, 1}, &do_create_map(&1, &2, 0))
    |> then(fn {map, _} -> map end)
  end

  defp do_create_map({[], _index}, {map, key}, _inner_index) do
    {map, key}
  end

  defp do_create_map({["#" | tail], index}, {map, key}, inner_index),
    do:
      do_create_map(
        {tail, index},
        {make_inner_map(map, key, {inner_index, index}), key + 1},
        inner_index + 1
      )

  defp do_create_map({[_head | tail], index}, map_key_tuple, inner_index),
    do: do_create_map({tail, index}, map_key_tuple, inner_index + 1)

  defp make_inner_map(map, key, point), do: Map.put(map, key, point)

  defp expand_horizontal(list) do
    list
    |> Enum.reduce([], fn str, acc ->
      str
      |> String.split("", trim: true)
      |> Enum.all?(&(&1 == "."))
      |> case do
        true ->
          [str, str | acc]

        _ ->
          [str | acc]
      end
    end)
    |> Enum.reverse()
  end

  defp expand_vertical(list) do
    list
    |> Enum.map(&String.split(&1, "", trim: true))
    |> Helpers.transpose()
    |> Enum.reduce([], fn str_list, acc ->
      if Enum.all?(str_list, &(&1 == ".")) do
        [str_list, str_list | acc]
      else
        [str_list | acc]
      end
    end)
    |> Enum.reverse()
    |> Helpers.transpose()
  end

  defp manhattan_distance({x1, y1}, {x2, y2}),
    do: abs(x1 - x2) + abs(y1 - y2)
end
