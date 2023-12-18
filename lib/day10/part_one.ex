defmodule Day10.PartOne do
  @path_mappings %{
    "up" => %{
      "|" => {{-1, 0}, "up"},
      "F" => {{0, 1}, "right"},
      "7" => {{0, -1}, "left"}
    },
    "right" => %{
      "-" => {{0, 1}, "right"},
      "J" => {{-1, 0}, "up"},
      "7" => {{1, 0}, "down"}
    },
    "down" => %{
      "|" => {{1, 0}, "down"},
      "J" => {{0, -1}, "left"},
      "L" => {{0, 1}, "right"}
    },
    "left" => %{
      "-" => {{0, -1}, "left"},
      "F" => {{1, 0}, "down"},
      "L" => {{-1, 0}, "up"}
    }
  }

  @valid_top ["|", "7", "F"]
  @valid_right ["-", "7", "J"]
  @valid_bottom ["|", "L", "J"]
  @valid_left ["-", "L", "F"]

  def run(input) do
    map =
      input
      |> Helpers.parse()
      |> Enum.with_index()
      |> Enum.reduce(%{}, fn {s, i}, acc ->
        Map.put(acc, i, inner_map(s))
      end)

    start = find_start(map)

    start_loop(map, start)
  end

  defp start_loop(map, {i1, i2} = start) do
    # start 4 loops
    # top, right, bottom, left

    top_coords = {i1 - 1, i2}
    right_coords = {i1, i2 + 1}
    bottom_coords = {i1 + 1, i2}
    left_coords = {i1, i2 - 1}

    top =
      if initial_valid?(map, top_coords, @valid_top) do
        find_loop(map, top_coords, start, [top_coords], "up")
      else
        nil
      end

    right =
      if initial_valid?(map, right_coords, @valid_right) do
        find_loop(map, right_coords, start, [right_coords], "right")
      else
        nil
      end

    bottom =
      if initial_valid?(map, bottom_coords, @valid_bottom) do
        find_loop(map, bottom_coords, start, [bottom_coords], "down")
      else
        nil
      end

    left =
      if initial_valid?(map, left_coords, @valid_left) do
        find_loop(map, left_coords, start, [left_coords], "left")
      else
        nil
      end

    Enum.reduce_while([top, right, bottom, left], 0, fn list, acc ->
      if is_nil(list) do
        {:cont, acc}
      else
        list
        |> Enum.count()
        |> Kernel./(2)
        |> trunc()
        |> then(&{:halt, &1})
      end
    end)
  end

  defp find_loop(_map, coords, start, acc, _dir) when coords == start, do: acc

  defp find_loop(map, {i1, i2}, start, acc, dir) do
    value =
      map
      |> Map.get(i1)
      |> Map.get(i2)

    @path_mappings
    |> Map.get(dir)
    |> Map.get(value)
    |> case do
      nil ->
        nil

      {{new_i1, new_i2}, new_dir} ->
        new_coords = {i1 + new_i1, i2 + new_i2}

        find_loop(map, new_coords, start, [new_coords | acc], new_dir)
    end
  end

  defp initial_valid?(map, {i1, i2}, list) do
    with v1 when not is_nil(v1) <- Map.get(map, i1),
         v2 when not is_nil(v2) <- Map.get(v1, i2) do
      v2 in list
    else
      _ ->
        false
    end
  end

  defp inner_map(str) do
    str
    |> String.split("", trim: true)
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {c, i}, acc ->
      Map.put(acc, i, c)
    end)
  end

  defp find_start(map) do
    Enum.reduce_while(map, nil, fn {k, v}, acc ->
      result =
        Enum.reduce_while(v, nil, fn {k2, v2}, acc2 ->
          if v2 == "S" do
            {:halt, k2}
          else
            {:cont, acc2}
          end
        end)

      if result do
        {:halt, {k, result}}
      else
        {:cont, acc}
      end
    end)
  end
end
