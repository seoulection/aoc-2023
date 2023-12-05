defmodule Day1.PartOne do
  def run(input) do
    input
    |> Helpers.parse()
    |> Enum.reduce(0, fn str, acc ->
      str
      |> String.split("", trim: true)
      |> find_digits(%{first_digit_found?: false, value: ""})
      |> Integer.parse()
      |> then(fn {num, _} -> num end)
      |> Kernel.+(acc)
    end)
  end

  defp find_digits([], %{value: value}), do: value <> value

  defp find_digits([head | tail], %{first_digit_found?: first_digit_found?, value: value} = map) do
    with {_, _} <- Integer.parse(head),
         true <- first_digit_found? do
      value <> head
    else
      :error ->
        find_digits(tail, map)

      _ ->
        map
        |> Map.put(:first_digit_found?, true)
        |> Map.put(:value, value <> head)
        |> then(fn new_map ->
          tail
          |> Enum.reverse()
          |> find_digits(new_map)
        end)
    end
  end
end
