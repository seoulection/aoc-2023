defmodule Day8.PartTwo do
  @instructions %{
    "L" => 0,
    "R" => 1
  }

  def run(input) do
    [instructions, "" | tail] = Helpers.parse(input)

    instructions =
      String.split(instructions, "", trim: true)

    input_map =
      Enum.reduce(tail, %{}, fn input_str, acc ->
        {key, unparsed_values} = parse_input_str(input_str)

        Map.put(acc, key, unparsed_values)
      end)

    input_map
    |> Map.keys()
    |> Enum.filter(&String.ends_with?(&1, "A"))
    |> Enum.map(fn key -> run_instruction_cycle(input_map, key, instructions, 1) end)
    |> find_lcm_recur()
  end

  defp find_lcm_recur([head, next | []]), do: lcm(head, next)

  defp find_lcm_recur([head | tail]), do: lcm(head, find_lcm_recur(tail))

  defp lcm(a, b) do
    value = a * b / Integer.gcd(a, b)

    trunc(value)
  end

  defp parse_input_str(input_str) do
    [key, unparsed_values] =
      String.split(input_str, " = ")

    parsed_values =
      unparsed_values
      |> String.replace("(", "")
      |> String.replace(")", "")
      |> String.split(", ")

    {key, parsed_values}
  end

  defp run_instruction_cycle(input_map, key, instructions, cycle) do
    result = do_run_instruction_cycle(input_map, key, instructions)

    if String.ends_with?(result, "Z") do
      Enum.count(instructions) * cycle
    else
      run_instruction_cycle(input_map, result, instructions, cycle + 1)
    end
  end

  defp do_run_instruction_cycle(_, key, []), do: key

  defp do_run_instruction_cycle(input_map, key, [head | tail]) do
    instruction = Map.get(@instructions, head)

    input_map
    |> Map.get(key)
    |> Enum.at(instruction)
    |> then(&do_run_instruction_cycle(input_map, &1, tail))
  end
end
