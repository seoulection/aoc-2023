defmodule Day21.PartOne do
  @directions %{
    north: {-1, 0},
    west: {0, -1},
    east: {0, 1},
    south: {1, 0}
  }
  @valid_spaces ["O", "S", "."]

  def run(input, steps \\ 64) do
    input
    |> Helpers.parse()
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {row, i1}, acc1 ->
      row
      |> String.split("", trim: true)
      |> Enum.with_index()
      |> Enum.reduce(%{}, fn {space, i2}, acc2 ->
        if space == "S" do
          Process.put(:start, {i1, i2})
        end

        acc2
        |> Map.put({i1, i2}, space)
        |> Map.merge(acc1)
      end)
    end)
    |> start_steps(Process.get(:start), steps)
    |> MapSet.size()
  end

  defp start_steps(grid, start, steps) do
    Enum.reduce(1..steps, MapSet.new([start]), fn _step, acc1 ->
      Enum.reduce(acc1, MapSet.new(), fn position, acc2 ->
        acc2
        |> maybe_add(walk(:north, position, grid))
        |> maybe_add(walk(:west, position, grid))
        |> maybe_add(walk(:east, position, grid))
        |> maybe_add(walk(:south, position, grid))
      end)
    end)
  end

  defp walk(direction, {i1, i2}, grid) do
    {d1, d2} = Map.get(@directions, direction)
    destination = {i1 + d1, i2 + d2}

    grid
    |> Map.get({i1 + d1, i2 + d2})
    |> case do
      result when result in @valid_spaces ->
        destination

      _ ->
        nil
    end
  end

  defp maybe_add(mapset, nil), do: mapset
  defp maybe_add(mapset, value), do: MapSet.put(mapset, value)
end
