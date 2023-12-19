defmodule Day15.PartTwo do
  def run(input) do
    input
    |> Helpers.parse()
    |> List.first()
    |> String.split(",")
    |> Enum.reduce(%{}, fn str, acc ->
      cond do
        String.contains?(str, "=") ->
          [label, num] = String.split(str, "=")
          {num, _} = Integer.parse(num)

          key = hash(label)

          maybe_put_map(acc, key, [label, num])

        String.contains?(str, "-") ->
          [label] = String.split(str, "-", trim: true)

          key = hash(label)

          case Map.get(acc, key) do
            nil ->
              acc

            result ->
              index = Enum.find_index(result, fn [t_label, _num] -> t_label == label end)

              if index do
                {list1, list2} = Enum.split(result, index + 1)

                list =
                  list1
                  |> Enum.drop(-1)
                  |> Kernel.++(list2)

                if Enum.count(list) == 0 do
                  Map.delete(acc, key)
                else
                  Map.put(acc, key, list)
                end
              else
                acc
              end
          end
      end
    end)
    |> then(fn map ->
      map
      |> Map.keys()
      |> Enum.reduce(0, fn key, acc ->
        first = key + 1

        map
        |> Map.get(key)
        |> Enum.map(fn [_, num] -> num end)
        |> Enum.with_index(fn element, index -> {element, index + 1} end)
        |> Enum.reduce(0, fn {val, spot}, acc ->
          acc + first * val * spot
        end)
        |> Kernel.+(acc)
      end)
    end)
  end

  defp maybe_put_map(map, key, [label, _num] = split) do
    with {:map, result} when not is_nil(result) <- {:map, Map.get(map, key)},
         {:index, {index, _result}} when not is_nil(index) <-
           {:index, {Enum.find_index(result, fn [t_label, _num] -> label == t_label end), result}} do
      {list1, list2} = Enum.split(result, index + 1)

      list1 =
        list1
        |> Enum.drop(-1)
        |> Enum.reverse()

      [split | list1]
      |> Enum.reverse()
      |> Kernel.++(list2)
      |> then(&Map.put(map, key, &1))
    else
      {:map, nil} ->
        Map.put(map, key, [split])

      {:index, {nil, result}} ->
        Map.put(map, key, new_result(result, split))
    end
  end

  defp new_result(list, split) do
    new_list = Enum.reverse(list)

    Enum.reverse([split | new_list])
  end

  defp hash(str) do
    str
    |> String.to_charlist()
    |> Enum.reduce(0, fn ascii, acc ->
      ascii
      |> Kernel.+(acc)
      |> Kernel.*(17)
      |> rem(256)
    end)
  end
end
