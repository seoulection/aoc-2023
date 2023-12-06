defmodule Day6.PartOne do
  def run(input) do
    input
    |> Helpers.parse()
    |> Enum.map(fn str ->
      str
      |> String.split(": ", trim: true)
      |> List.last()
      |> String.split(" ", trim: true)
    end)
    |> List.zip()
    |> calculate_ggs(1)
  end

  defp calculate_ggs([], ways), do: ways

  defp calculate_ggs([{time_str, distance_str} | tail], ways) do
    {time, _} = Integer.parse(time_str)
    {distance, _} = Integer.parse(distance_str)

    new_ways = calculate_ways(time, distance)

    calculate_ggs(tail, ways * new_ways)
  end

  defp calculate_ways(time, distance) do
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
