defmodule Day19.PartOne do
  @accepted "A"
  @rejected "R"

  def run(input) do
    {instructions, mappings} = parse_input(input)

    Enum.reduce(instructions, 0, fn instruction, acc ->
      instruction
      |> run_workflow(mappings, "in")
      |> case do
        @accepted ->
          instruction
          |> Map.values()
          |> Enum.sum()
          |> Kernel.+(acc)

        _ ->
          acc
      end
    end)
  end

  defp run_workflow(_instruction, _mappings, key) when key in [@accepted, @rejected], do: key

  defp run_workflow(instruction, mappings, key) do
    mappings
    |> Map.get(key)
    |> then(&maybe_parse(instruction, &1))
    |> then(&run_workflow(instruction, mappings, &1))
  end

  defp maybe_parse(input, [head | tail]) do
    with [_, _] = list <- String.split(head, ":"),
         nil <-
           get_result(list, input) do
      maybe_parse(input, tail)
    else
      [result] ->
        result

      key when key in [@accepted, @rejected] ->
        key

      key ->
        key
    end
  end

  defp get_result([x1, _x2] = list, input) do
    if String.contains?(x1, ">") do
      do_get_result(list, input, ">")
    else
      do_get_result(list, input, "<")
    end
  end

  defp do_get_result([x1, x2], input, ">" = operand) do
    [key, value] = String.split(x1, operand)

    if Map.get(input, key) > parse_int(value) do
      x2
    else
      nil
    end
  end

  defp do_get_result([x1, x2], input, "<" = operand) do
    [key, value] = String.split(x1, operand)

    if Map.get(input, key) < parse_int(value) do
      x2
    else
      nil
    end
  end

  defp parse_input(input) do
    {instructions, mappings} =
      input
      |> Helpers.parse()
      |> Enum.reject(&(&1 == ""))
      |> Enum.split_with(&String.starts_with?(&1, "{"))

    instructions =
      Enum.reduce(instructions, [], fn instruction, acc ->
        instruction
        |> String.replace("{", "")
        |> String.replace("}", "")
        |> String.split(",")
        |> Enum.reduce(%{}, fn kv, acc ->
          [key, str] = String.split(kv, "=")

          {num, _} = Integer.parse(str)

          Map.put(acc, key, num)
        end)
        |> then(&[&1 | acc])
      end)

    mappings =
      Enum.reduce(mappings, %{}, fn mapping, acc ->
        [key, process] = String.split(mapping, "{")

        process = String.replace(process, "}", "")

        Map.put(acc, key, String.split(process, ","))
      end)

    {instructions, mappings}
  end

  defp parse_int(str) do
    {num, _} = Integer.parse(str)

    num
  end
end
