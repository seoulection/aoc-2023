defmodule Day3.PartOne do
  def run(input) do
    parsed_input = Helpers.parse(input)

    all_list = Enum.map(parsed_input, &String.split(&1, "", trim: true))

    parse_schematic(parsed_input, 0, Enum.count(all_list) - 1, 0, all_list)
  end

  defp parse_schematic([], _, _, sum, _), do: sum

  defp parse_schematic([head | tail], index, ending_index, sum, all_list) do
    list =
      head
      |> String.split("", trim: true)
      |> Enum.with_index()

    num = add_numbers(list, "", 0, false, index, ending_index, all_list, Enum.count(list) - 1)

    parse_schematic(tail, index + 1, ending_index, sum + num, all_list)
  end

  defp add_numbers([], num_str, sum, true, _, _, _, _) do
    {num, _} = Integer.parse(num_str)

    num + sum
  end

  defp add_numbers([], _, sum, _, _, _, _, _), do: sum

  defp add_numbers(
         [{h_v, h_i} | tail],
         num_str,
         sum,
         symbol_found?,
         index,
         ending_index,
         all_list,
         ending_local_index
       ) do
    case Integer.parse(h_v) do
      :error ->
        if num_str != "" do
          {num, _} = Integer.parse(num_str)

          if symbol_found? do
            add_numbers(
              tail,
              "",
              sum + num,
              false,
              index,
              ending_index,
              all_list,
              ending_local_index
            )
          else
            add_numbers(
              tail,
              "",
              sum,
              symbol_found?,
              index,
              ending_index,
              all_list,
              ending_local_index
            )
          end
        else
          add_numbers(
            tail,
            num_str,
            sum,
            symbol_found?,
            index,
            ending_index,
            all_list,
            ending_local_index
          )
        end

      _ ->
        symbol_found? =
          if adjacent_symbols?(index, h_i, all_list, ending_index, ending_local_index) do
            true
          else
            symbol_found?
          end

        add_numbers(
          tail,
          num_str <> h_v,
          sum,
          symbol_found?,
          index,
          ending_index,
          all_list,
          ending_local_index
        )
    end
  end

  defp adjacent_symbols?(index, h_i, all_list, ending_index, ending_local_index) do
    index
    |> generate_indices(h_i, ending_index, ending_local_index)
    |> Enum.reduce_while(false, fn {i1, i2}, acc ->
      all_list
      |> Enum.at(i1)
      |> Enum.at(i2)
      |> String.match?(~r/^(?!\d+$)[^.]*$/)
      |> case do
        true ->
          {:halt, true}

        _ ->
          {:cont, acc}
      end
    end)
  end

  defp generate_indices(0, 0, _, _) do
    [
      {0, 1},
      {1, 0},
      {1, 1}
    ]
  end

  defp generate_indices(0, h_i, _, ending_local_index) when h_i == ending_local_index do
    [
      {0, h_i - 1},
      {1, h_i - 1},
      {1, h_i}
    ]
  end

  defp generate_indices(0, h_i, _, _) do
    [
      {0, h_i - 1},
      {0, h_i + 1},
      {1, h_i - 1},
      {1, h_i},
      {1, h_i + 1}
    ]
  end

  defp generate_indices(index, 0, ending_index, _) when index == ending_index do
    [
      {index - 1, 0},
      {index - 1, 1},
      {index, 0}
    ]
  end

  defp generate_indices(index, h_i, ending_index, ending_local_index)
       when index == ending_index and h_i == ending_local_index do
    [
      {index - 1, h_i - 1},
      {index - 1, h_i},
      {index, h_i - 1}
    ]
  end

  defp generate_indices(index, h_i, ending_index, _) when index == ending_index do
    [
      {index - 1, h_i - 1},
      {index - 1, h_i},
      {index - 1, h_i + 1},
      {index, h_i - 1},
      {index, h_i + 1}
    ]
  end

  defp generate_indices(index, 0, _, _) do
    [
      {index - 1, 0},
      {index - 1, 1},
      {index, 1},
      {index + 1, 0},
      {index + 1, 1}
    ]
  end

  defp generate_indices(index, h_i, _, ending_local_index) when h_i == ending_local_index do
    [
      {index - 1, h_i - 1},
      {index - 1, h_i},
      {index, h_i - 1},
      {index + 1, h_i - 1},
      {index + 1, h_i}
    ]
  end

  defp generate_indices(index, h_i, _, _) do
    [
      {index - 1, h_i - 1},
      {index - 1, h_i},
      {index - 1, h_i + 1},
      {index, h_i - 1},
      {index, h_i + 1},
      {index + 1, h_i - 1},
      {index + 1, h_i},
      {index + 1, h_i + 1}
    ]
  end
end
