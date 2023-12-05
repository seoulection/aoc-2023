defmodule Day1.PartTwo do
  @num_mappings [
    {"one", 1, 3},
    {"two", 2, 3},
    {"three", 3, 5},
    {"four", 4, 4},
    {"five", 5, 4},
    {"six", 6, 3},
    {"seven", 7, 5},
    {"eight", 8, 5},
    {"nine", 9, 4}
  ]

  def run(input) do
    input
    |> Helpers.parse()
    |> Enum.reduce(0, fn str, acc ->
      str
      |> String.split("", trim: true)
      |> find_digits(%{first_digit_found?: false, mappings: @num_mappings, value: ""})
      |> Integer.parse()
      |> then(fn {num, _} -> num end)
      |> Kernel.+(acc)
    end)
  end

  defp find_digits([], %{value: value}), do: value <> value

  defp find_digits([_head | tail], %{mappings: []} = map) do
    find_digits(tail, Map.put(map, :mappings, @num_mappings))
  end

  defp find_digits(
         [head | tail] = list,
         %{first_digit_found?: false, mappings: [{text, num, length} | mappings_t], value: value} =
           map
       ) do
    case Integer.parse(head) do
      :error ->
        if String.starts_with?(text, head) do
          tail_str =
            tail
            |> Enum.take(length - 1)
            |> Enum.join()

          str = head <> tail_str

          if str == text do
            new_map =
              map
              |> Map.put(:first_digit_found?, true)
              |> Map.put(:mappings, @num_mappings)
              |> Map.put(:value, value <> "#{num}")

            tail
            |> Enum.reverse()
            |> find_digits(new_map)
          else
            find_digits(list, Map.put(map, :mappings, mappings_t))
          end
        else
          find_digits(list, Map.put(map, :mappings, mappings_t))
        end

      {parsed_num, _} ->
        new_map =
          map
          |> Map.put(:first_digit_found?, true)
          |> Map.put(:mappings, @num_mappings)
          |> Map.put(:value, value <> "#{parsed_num}")

        tail
        |> Enum.reverse()
        |> find_digits(new_map)
    end
  end

  defp find_digits(
         [head | tail] = list,
         %{mappings: [{text, num, length} | mappings_t], value: value} = map
       ) do
    case Integer.parse(head) do
      :error ->
        reversed_text = String.reverse(text)

        if String.starts_with?(reversed_text, head) do
          tail_str =
            tail
            |> Enum.take(length - 1)
            |> Enum.join()

          str = head <> tail_str

          if str == reversed_text do
            value <> "#{num}"
          else
            find_digits(list, Map.put(map, :mappings, mappings_t))
          end
        else
          find_digits(list, Map.put(map, :mappings, mappings_t))
        end

      {parsed_num, _} ->
        value <> "#{parsed_num}"
    end
  end
end
