defmodule Day5.PartTwo do
  @mappers [
    "seed-to-soil",
    "soil-to-fertilizer",
    "fertilizer-to-water",
    "water-to-light",
    "light-to-temperature",
    "temperature-to-humidity",
    "humidity-to-location"
  ]

  def run(input) do
    [seeds, _ | tail] = Helpers.parse(input)

    seeds =
      seeds
      |> parse_seeds()
      |> Enum.chunk_every(2)
      |> Enum.map(fn [first, last] -> first..(first + last - 1) end)

    almanac = create_almanac(tail)

    [range.._ | _tail] =
      @mappers
      |> Enum.reduce(
        seeds,
        &get_ranges(&2, Map.get(almanac, &1))
      )
      |> Enum.sort()
      |> Enum.uniq()
      |> Enum.reject(fn r1.._r2 -> r1 == 0 end)

    range
  end

  defp get_ranges(ranges, mapper_ranges) do
    Enum.reduce(ranges, [], fn range, acc ->
      acc ++ do_get_ranges(range, mapper_ranges, [])
    end)
  end

  def do_get_ranges(range, [], []), do: [range]

  def do_get_ranges(_, [], acc), do: acc

  def do_get_ranges(r1..r2 = range, [{s1..s2, _} | tail], acc) when r1 > s2 or r2 < s1,
    do: do_get_ranges(range, tail, acc)

  def do_get_ranges(r1..r2 = range, [{s1..s2, d1..d2} | tail], acc) when r1 >= s1 and r2 <= s2,
    do: do_get_ranges(range, tail, acc ++ [(r1 - s1 + d1)..(d2 - (s2 - r2))])

  def do_get_ranges(r1..r2 = range, [{s1..s2, d1..d2} | tail], acc) when r1 >= s1 and r2 > s2 do
    first_range = (r1 - s1 + d1)..d2
    second_range = (s2 + 1)..r2

    do_get_ranges(range, tail, acc ++ [first_range, second_range])
  end

  def do_get_ranges(r1..r2 = range, [{s1..s2, d1..d2} | tail], acc) when r1 < s1 and r2 <= s2 do
    first_range = r1..(s1 - 1)
    second_range = d1..(d2 - (s2 - r2))

    do_get_ranges(range, tail, acc ++ [first_range, second_range])
  end

  def do_get_ranges(r1..r2 = range, [{s1..s2, d1..d2} | tail], acc) when r1 < s1 and r2 > s2 do
    first_range = r1..(s1 - 1)
    second_range = d1..d2
    third_range = (s2 + 1)..r2

    do_get_ranges(range, tail, acc ++ [first_range, second_range, third_range])
  end

  defp parse_seeds(seeds) do
    seeds
    |> String.split(": ")
    |> List.last()
    |> String.split(" ")
    |> Enum.map(fn seed_str ->
      {num, _} = Integer.parse(seed_str)

      num
    end)
  end

  defp create_almanac(list) do
    list
    |> Enum.chunk_by(&(&1 == ""))
    |> Enum.reject(fn el -> el == [""] end)
    |> Enum.reduce(%{}, fn el, acc ->
      [key_str | values] = el

      [key | _] = String.split(key_str, " ")

      values =
        Enum.map(values, fn value ->
          value
          |> String.split(" ", trim: true)
          |> Enum.map(fn x ->
            {num, _} = Integer.parse(x)

            num
          end)
        end)

      # {source_range, destination_range}
      places =
        Enum.reduce(values, [], fn [d, s, l], acc ->
          acc ++
            [
              {s..(s + l - 1), d..(d + l - 1)}
            ]
        end)

      Map.put(acc, key, places)
    end)
  end
end
