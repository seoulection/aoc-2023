defmodule Day14.PartOne do
  @cube "#"
  @empty "."
  @round "O"

  def run(input) do
    input
    |> Helpers.parse()
    |> Enum.map(&String.split(&1, "", trim: true))
    |> Helpers.transpose()
    |> Enum.map(&tilt/1)
    |> Helpers.transpose()
    |> Enum.reverse()
    |> Enum.with_index(fn element, index -> {element, index + 1} end)
    |> Enum.reduce(0, fn {element, index}, acc ->
      element
      |> Enum.count(&(&1 == @round))
      |> Kernel.*(index)
      |> Kernel.+(acc)
    end)
  end

  defp tilt(list) do
    list
    |> Enum.chunk_by(&(&1 == @cube))
    |> do_tilt([])
  end

  defp do_tilt([], acc) do
    acc
    |> Enum.reverse()
    |> List.flatten()
  end

  defp do_tilt([head | tail], acc) do
    case Enum.count(head, &(&1 == @round)) do
      0 ->
        do_tilt(tail, [head | acc])

      round_count ->
        list =
          []
          |> construct_list(round_count, Enum.count(head))
          |> Enum.reverse()

        do_tilt(tail, [list | acc])
    end
  end

  defp construct_list(list, _, 0), do: list

  defp construct_list(list, 0, length), do: construct_list([@empty | list], 0, length - 1)

  defp construct_list(list, round_count, length) when round_count > 0,
    do: construct_list([@round | list], round_count - 1, length - 1)
end
