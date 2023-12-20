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

      vertical_grid =
        grid
        |> Helpers.transpose()
        |> Enum.with_index(fn element, index -> {element, index + 1} end)

      vertical1 =
        find_reflection(vertical_grid, vertical_grid)

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
        if head_list == tail_list do
          {first, second} = Enum.split(grid, head_index)

          value = find_reflection(first, second, head_index)

          if value == 0 do
            find_reflection(tail, grid)
          else
            value
          end
        else
          find_reflection(tail, grid)
        end
    end
  end

  defp find_reflection(first, second, head_index) do
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

        IO.inspect(first_list, label: "FIRST LIST")
        IO.inspect(second, label: "SECOND LIST")

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
end
