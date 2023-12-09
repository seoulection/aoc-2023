defmodule Day8.PartOne do
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

    run_instruction_cycle(input_map, "AAA", instructions, 1)
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
    case do_run_instruction_cycle(input_map, key, instructions, cycle) do
      "ZZZ" ->
        Enum.count(instructions) * cycle

      key ->
        run_instruction_cycle(input_map, key, instructions, cycle + 1)
    end
  end

  defp do_run_instruction_cycle(_, key, [], _cycle), do: key

  defp do_run_instruction_cycle(input_map, key, [head | tail], cycle) do
    instruction = Map.get(@instructions, head)

    input_map
    |> Map.get(key)
    |> Enum.at(instruction)
    |> then(&do_run_instruction_cycle(input_map, &1, tail, cycle))
  end
end
