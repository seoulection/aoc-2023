defmodule Day4.PartOne do
  def run(input) do
    input
    |> Helpers.parse()
    |> Enum.map(fn str ->
      str
      |> String.split(": ")
      |> List.last()
      |> String.split(" | ")
      |> Enum.map(&to_list/1)
    end)
    |> Enum.reduce(0, fn [winning_numbers, your_numbers], acc ->
      winning_numbers
      |> get_common_values(your_numbers)
      |> case do
        [_, _, _ | _] = result ->
          2
          |> :math.pow(Enum.count(result) - 1)
          |> trunc()

        result ->
          Enum.count(result)
      end
      |> Kernel.+(acc)
    end)
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
