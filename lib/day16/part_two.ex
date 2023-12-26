defmodule Day16.PartTwo do
  @directions %{
    down: {1, 0},
    left: {0, -1},
    right: {0, 1},
    up: {-1, 0}
  }

  def run(input) do
    map =
      input
      |> Helpers.parse()
      |> Enum.map(&String.to_charlist/1)
      |> create_map()

    cols_count =
      map
      |> Map.get(0)
      |> Enum.count()

    rows_count =
      map
      |> Map.keys()
      |> Enum.count()

    [:bottom, :left, :right, :top]
    |> Task.async_stream(fn row -> start_from_row(row, map, cols_count, rows_count) end)
    |> Stream.map(&elem(&1, 1))
    |> Enum.max()
  end

  defp start_from_row(:bottom, map, cols_count, rows_count) do
    0..(cols_count - 1)
    |> Task.async_stream(fn col ->
      map
      |> energize({rows_count - 1, col}, :up, MapSet.new())
      |> MapSet.size()
    end)
    |> Stream.map(&elem(&1, 1))
    |> Enum.max()
  end

  defp start_from_row(:left, map, _cols_count, rows_count) do
    0..(rows_count - 1)
    |> Task.async_stream(fn row ->
      map
      |> energize({row, 0}, :right, MapSet.new())
      |> MapSet.size()
    end)
    |> Stream.map(&elem(&1, 1))
    |> Enum.max()
  end

  defp start_from_row(:right, map, cols_count, rows_count) do
    0..(rows_count - 1)
    |> Task.async_stream(fn row ->
      map
      |> energize({row, cols_count - 1}, :left, MapSet.new())
      |> MapSet.size()
    end)
    |> Stream.map(&elem(&1, 1))
    |> Enum.max()
  end

  defp start_from_row(:top, map, cols_count, _rows_count) do
    0..(cols_count - 1)
    |> Task.async_stream(fn col ->
      map
      |> energize({0, col}, :down, MapSet.new())
      |> MapSet.size()
    end)
    |> Stream.map(&elem(&1, 1))
    |> Enum.max()
  end

  defp energize(map, {y, x} = coordinates, direction, set) do
    case Kernel.get_in(map, [y, x]) do
      ?. ->
        energize(map, move(coordinates, direction), direction, MapSet.put(set, coordinates))

      nil ->
        set

      mirror ->
        mirror(map, mirror, coordinates, direction, set)
    end
  end

  defp mirror(map, ?-, coordinates, direction, set) when direction in [:down, :up] do
    if loop?(coordinates, direction) do
      set
    else
      set1 = energize(map, move(coordinates, :left), :left, MapSet.put(set, coordinates))
      set2 = energize(map, move(coordinates, :right), :right, MapSet.put(set, coordinates))

      MapSet.union(set1, set2)
    end
  end

  defp mirror(map, ?|, coordinates, direction, set) when direction in [:left, :right] do
    if loop?(coordinates, direction) do
      set
    else
      set1 = energize(map, move(coordinates, :down), :down, MapSet.put(set, coordinates))
      set2 = energize(map, move(coordinates, :up), :up, MapSet.put(set, coordinates))

      MapSet.union(set1, set2)
    end
  end

  defp mirror(map, ?/, coordinates, direction, set) do
    if loop?(coordinates, direction) do
      set
    else
      case direction do
        :down ->
          energize(map, move(coordinates, :left), :left, MapSet.put(set, coordinates))

        :left ->
          energize(map, move(coordinates, :down), :down, MapSet.put(set, coordinates))

        :right ->
          energize(map, move(coordinates, :up), :up, MapSet.put(set, coordinates))

        :up ->
          energize(map, move(coordinates, :right), :right, MapSet.put(set, coordinates))
      end
    end
  end

  defp mirror(map, ?\\, coordinates, direction, set) do
    if loop?(coordinates, direction) do
      set
    else
      case direction do
        :down ->
          energize(map, move(coordinates, :right), :right, MapSet.put(set, coordinates))

        :left ->
          energize(map, move(coordinates, :up), :up, MapSet.put(set, coordinates))

        :right ->
          energize(map, move(coordinates, :down), :down, MapSet.put(set, coordinates))

        :up ->
          energize(map, move(coordinates, :left), :left, MapSet.put(set, coordinates))
      end
    end
  end

  defp mirror(map, _, coordinates, direction, set),
    do: energize(map, move(coordinates, direction), direction, MapSet.put(set, coordinates))

  defp move({y, x}, direction) do
    {offset_y, offset_x} = Map.get(@directions, direction)

    {y + offset_y, x + offset_x}
  end

  defp create_map(input) do
    input
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {charlist, index}, outer_acc ->
      charlist
      |> Enum.with_index()
      |> Enum.reduce(%{}, fn {char, index}, inner_acc ->
        Map.put(inner_acc, index, char)
      end)
      |> then(&Map.put(outer_acc, index, &1))
    end)
  end

  defp loop?(coordinates, direction) do
    if Process.get(coordinates) == direction do
      true
    else
      Process.put(coordinates, direction)

      false
    end
  end
end
