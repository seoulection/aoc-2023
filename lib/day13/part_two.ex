defmodule Day13.PartTwo do
  def run(input) do
    input
    |> String.trim_trailing()
    |> String.split("\n\n")
    |> Enum.map(fn str ->
      str
      |> String.split("\n")
      |> Enum.map(&String.split(&1, "", trim: true))
    end)
    |> Enum.reduce([horizontal: 0, vertical: 0], fn grid,
                                                    [horizontal: horizontal, vertical: vertical] ->
      grid_with_index = Enum.with_index(grid, fn element, index -> {element, index + 1} end)

      horizontal1 =
        find_reflection(grid_with_index, grid_with_index)

      IO.inspect(grid, label: "GRID")

      vertical_grid =
        grid
        |> Helpers.transpose()
        |> Enum.with_index(fn element, index -> {element, index + 1} end)

      vertical1 =
        find_reflection(vertical_grid, vertical_grid)

      IO.inspect(horizontal1, label: "HORIZONTAL")

      vertical1 = if horizontal1 == 0, do: vertical1, else: 0
      IO.inspect(vertical1, label: "VERTICAL")

      [horizontal: horizontal + horizontal1, vertical: vertical + vertical1]
    end)
    |> then(fn [horizontal: horizontal, vertical: vertical] ->
      vertical + 100 * horizontal
    end)
  end

  defp find_reflection([], _), do: 0

  defp find_reflection([{head_list, head_index} | tail], grid) do
    case List.first(tail) do
      nil ->
        0

      {tail_list, _tail_index} ->
        cond do
          head_list == tail_list ->
            {first, second} = Enum.split(grid, head_index)

            first
            |> find_reflection(second, head_index, smudge?: false)
            |> case do
              0 ->
                find_reflection(tail, grid)

              value ->
                value
            end

          true ->
            h_ms = create_mapset(head_list)
            t_ms = create_mapset(tail_list)

            h_ms
            |> MapSet.difference(t_ms)
            |> MapSet.size()
            |> case do
              1 ->
                # get first and second
                {first, second} =
                  grid
                  |> Enum.split(head_index)
                  |> then(fn {first, second} ->
                    first = Enum.drop(first, -1)
                    second = Enum.drop(second, 1)

                    {first, second}
                  end)

                find_reflection(first, second, head_index, smudge?: true)

              _ ->
                find_reflection(tail, grid)
            end
        end
    end
  end

  defp create_mapset(list) do
    list
    |> Enum.with_index()
    |> MapSet.new()
  end

  defp find_reflection(first, second, head_index, smudge?: true) do
    first = Enum.map(first, fn {list, _} -> list end)
    second = Enum.map(second, fn {list, _} -> list end)
    first_length = Enum.count(first)
    second_length = Enum.count(second)

    cond do
      first_length > second_length ->
        diff = first_length - second_length

        first_list =
          first
          |> Enum.drop(diff)
          |> Enum.reverse()

        if first_list == second do
          head_index
        else
          0
        end

      first_length < second_length ->
        diff = second_length - first_length

        second_list =
          second
          |> Enum.reverse()
          |> Enum.drop(diff)

        if first == second_list do
          head_index
        else
          0
        end
    end
  end

  defp find_reflection(first, second, head_index, smudge?: false) do
    first = Enum.map(first, fn {list, _} -> list end)
    second = Enum.map(second, fn {list, _} -> list end)
    first_length = Enum.count(first)
    second_length = Enum.count(second)

    cond do
      first_length > second_length ->
        diff = first_length - second_length

        first_list =
          first
          |> Enum.drop(diff)
          |> Enum.reverse()

        if first_list == second do
          head_index
        else
          0..(second_length - 1)
          |> Enum.reduce(0, fn index, acc ->
            first_ms =
              first_list
              |> Enum.at(index)
              |> create_mapset()

            second_ms =
              second
              |> Enum.at(index)
              |> create_mapset()

            first_ms
            |> MapSet.difference(second_ms)
            |> MapSet.size()
            |> Kernel.+(acc)
          end)
          |> case do
            result when result > 1 ->
              0

            _ ->
              head_index
          end
        end

      first_length < second_length ->
        diff = second_length - first_length

        second_list =
          second
          |> Enum.reverse()
          |> Enum.drop(diff)

        if first == second_list do
          head_index
        else
          0..(first_length - 1)
          |> Enum.reduce(0, fn index, acc ->
            first_ms =
              first
              |> Enum.at(index)
              |> create_mapset()

            second_ms =
              second_list
              |> Enum.at(index)
              |> create_mapset()

            first_ms
            |> MapSet.difference(second_ms)
            |> MapSet.size()
            |> Kernel.+(acc)
          end)
          |> case do
            result when result > 1 ->
              0

            _ ->
              head_index
          end
        end
    end
  end
end
