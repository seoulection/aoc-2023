defmodule Day6.PartTwo do
  def run(input) do
    [time, distance] =
      input
      |> Helpers.parse()
      |> Enum.map(fn str ->
        str
        |> String.split(": ", trim: true)
        |> List.last()
        |> String.split(" ", trim: true)
        |> Enum.join("")
        |> Integer.parse()
        |> then(&elem(&1, 0))
      end)

    Enum.reduce(1..(time - 1), 0, fn ms, acc ->
      speed = time - ms

      if speed * ms > distance do
        acc + 1
      else
        acc
      end
    end)
  end
end
