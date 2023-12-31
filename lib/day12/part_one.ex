defmodule Day12.PartOne do
  def run(input) do
    input
    |> Helpers.parse()
    |> Enum.map(fn str ->
      str
      |> String.split(" ")
      |> parse_instructions()
    end)
    |> Enum.reduce(0, fn {record, instructions}, acc ->
      acc + scan(record, ".", instructions)
    end)
  end

  defp scan("", _, []), do: 1
  defp scan("", _, [0]), do: 1
  defp scan("", _, _), do: 0
  defp scan("#" <> _, _, []), do: 0
  defp scan("#" <> _, _, [0 | _]), do: 0
  defp scan("#" <> rest, _, [head | tail]), do: scan(rest, "#", [head - 1 | tail])
  defp scan("." <> rest, _, []), do: scan(rest, ".", [])
  defp scan("." <> rest, "#", [0 | tail]), do: scan(rest, ".", tail)
  defp scan("." <> _, "#", [_ | _]), do: 0
  defp scan("." <> rest, ".", instructions), do: scan(rest, ".", instructions)
  defp scan("?" <> rest, "#", []), do: scan(rest, ".", [])
  defp scan("?" <> rest, "#", [0 | tail]), do: scan(rest, ".", tail)
  defp scan("?" <> rest, "#", [head | tail]), do: scan(rest, "#", [head - 1 | tail])
  defp scan("?" <> rest, ".", []), do: scan(rest, ".", [])
  defp scan("?" <> rest, ".", [0 | tail]), do: scan(rest, ".", tail)

  defp scan("?" <> rest, ".", [head | tail] = instructions),
    do: scan(rest, "#", [head - 1 | tail]) + scan(rest, ".", instructions)

  defp parse_instructions([record, instructions]) do
    instructions
    |> String.split(",")
    |> Enum.map(fn str ->
      {num, _} = Integer.parse(str)

      num
    end)
    |> then(&{record, &1})
  end
end
