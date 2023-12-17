defmodule Day3.PartTwo do
  def run(input) do
    input_map =
      input
      |> Helpers.parse()
      |> Enum.with_index()
      |> Enum.reduce(%{}, fn {str, index}, acc ->
        str
        |> String.split("", trim: true)
        |> Enum.with_index()
        |> Enum.reduce(%{}, fn {v, i}, acc -> Map.put(acc, i, v) end)
        |> then(&Map.put(acc, index, &1))
      end)

    input_map
    |> find_gears()
    |> get_ratios(input_map, 0)
  end

  defp find_gears(input_map) do
    input_map
    |> Map.keys()
    |> Enum.reduce([], fn k1, acc1 ->
      input_map
      |> Map.get(k1)
      |> Enum.reduce([], fn {k2, v}, acc2 ->
        if v == "*" do
          [{k1, k2} | acc2]
        else
          acc2
        end
      end)
      |> case do
        [] ->
          acc1

        result ->
          [result | acc1]
      end
      |> List.flatten()
    end)
  end

  defp get_ratios([], _, acc), do: acc

  defp get_ratios([{i1, i2} | tail], input_map, acc) do
    top = row(input_map, i1 - 1, i2)
    middle = middle_row(input_map, i1, i2)
    bottom = row(input_map, i1 + 1, i2)

    result = top ++ middle ++ bottom

    if Enum.count(result) == 2 do
      [{i11, i12}, {i21, i22}] = result

      row1 = Map.get(input_map, i11)
      row2 = Map.get(input_map, i21)

      ratio1 = get_number(row1, i12, "")
      ratio2 = get_number(row2, i22, "")

      get_ratios(tail, input_map, ratio1 * ratio2 + acc)
    else
      get_ratios(tail, input_map, acc)
    end
  end

  defp get_number(row, i2, str) do
    row
    |> Map.get(i2)
    |> case do
      nil ->
        parse_str(str)

      v ->
        case Integer.parse(v) do
          :error ->
            parse_str(str)

          _ ->
            get_number(row, i2 + 1, str <> v)
        end
    end
  end

  defp parse_str(str) do
    {num, _} = Integer.parse(str)

    num
  end

  defp row(input_map, i1, i2) do
    case Map.get(input_map, i1) do
      nil ->
        []

      result ->
        [i2 - 1, i2, i2 + 1]
        |> Enum.reduce([], fn i, acc ->
          coordinates = maybe_find_number(result, i1, i, {nil, nil})

          if is_nil(coordinates) do
            acc
          else
            [coordinates | acc]
          end
        end)
        |> Enum.uniq()
    end
  end

  defp middle_row(input_map, i1, i2) do
    left = i2 - 1
    right = i2 + 1

    row = Map.get(input_map, i1)

    right_coordinates =
      case Map.get(row, right) do
        nil ->
          []

        v ->
          v
          |> Integer.parse()
          |> case do
            :error ->
              []

            _ ->
              [{i1, right}]
          end
      end

    row
    |> maybe_find_number(i1, left, {nil, nil})
    |> case do
      nil ->
        right_coordinates

      left_coordinates ->
        [left_coordinates] ++ right_coordinates
    end
  end

  defp maybe_find_number(result, i1, i2, {nil, nil}) do
    result
    |> Map.get(i2)
    |> case do
      nil ->
        nil

      v ->
        v
        |> Integer.parse()
        |> case do
          :error ->
            nil

          _ ->
            maybe_find_number(result, i1, i2 - 1, {i1, i2})
        end
    end
  end

  defp maybe_find_number(result, i1, i2, coordinates) do
    result
    |> Map.get(i2)
    |> case do
      nil ->
        coordinates

      v ->
        v
        |> Integer.parse()
        |> case do
          :error ->
            coordinates

          _ ->
            maybe_find_number(result, i1, i2 - 1, {i1, i2})
        end
    end
  end
end
