defmodule Day12.PartTwo do
  def run(input) do
    input
    |> Helpers.parse()
    |> Enum.map(fn str ->
      str
      |> String.split(" ")
      |> parse()
    end)
    |> Task.async_stream(fn {record, instructions} ->
      scan(record, ".", instructions)
    end)
    |> Stream.map(&elem(&1, 1))
    |> Enum.sum()
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

  defp scan("?" <> rest, ".", [head | tail] = instructions) do
    memoize({rest, instructions}, fn ->
      scan(rest, "#", [head - 1 | tail]) + scan(rest, ".", instructions)
    end)
  end

  defp parse([record, instructions]) do
    instructions
    |> String.split(",")
    |> Enum.map(fn str ->
      {num, _} = Integer.parse(str)

      num
    end)
    |> then(fn instructions ->
      record =
        record
        |> String.split("", trim: true)
        |> List.duplicate(5)
        |> Enum.join("?")

      instructions =
        instructions
        |> List.duplicate(5)
        |> List.flatten()

      {record, instructions}
    end)
  end

  defp memoize(key, fun) do
    case Process.get(key) do
      nil ->
        tap(fun.(), &Process.put(key, &1))

      result ->
        result
    end
  end
end
