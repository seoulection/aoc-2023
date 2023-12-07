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

  # 79..92

  def run(input) do
    [seeds, _ | tail] = Helpers.parse(input)

    seeds =
      seeds
      |> parse_seeds()
      |> Enum.chunk_every(2)
      |> Enum.map(fn [first, last] -> first..(first + last - 1) end)

    almanac =
      create_almanac(tail)
      |> IO.inspect()

    almanac = %{
      "fertilizer-to-water" => [
        {53..60, 49..56},
        {11..52, 0..41},
        {0..6, 42..48},
        {7..10, 57..60}
      ],
      "humidity-to-location" => [{56..92, 60..96}, {93..96, 56..59}],
      "light-to-temperature" => [
        {77..99, 45..67},
        {45..63, 81..99},
        {64..76, 68..80}
      ],
      "seed-to-soil" => [{52..99, 50..97}, {50..97, 52..99}],
      "soil-to-fertilizer" => [{15..51, 0..36}, {52..53, 37..38}, {0..14, 39..53}],
      "temperature-to-humidity" => [{69..69, 0..0}, {0..68, 1..69}],
      "water-to-light" => [{18..24, 88..94}, {25..94, 18..87}]
    }

    seeds = [44..100]

    [range.._ | _] =
      @mappers
      |> Enum.reduce(seeds, fn mapper, acc ->
        IO.inspect(acc, label: "ACC")
        get_ranges(acc, Map.get(almanac, mapper))
      end)
      |> Enum.sort()
      |> IO.inspect(label: "HEY", limit: :infinity)

    range
  end

  # r1 > s1, r2 > s2

  defp get_ranges(ranges, mapper_ranges) do
    Enum.reduce(ranges, [], fn range, acc ->
      IO.inspect(range, label: "RANGE")
      IO.inspect(mapper_ranges, label: "MAPPER RANGE")

      sup = do_get_ranges(range, mapper_ranges, [])

      IO.inspect(sup, label: "SUP")

      acc ++ sup
    end)
  end

  def do_get_ranges(_, [], acc), do: acc

  def do_get_ranges(r1..r2 = range, [{s1..s2, _} | tail], acc) when r1 > s2 or r2 < s1,
    do: do_get_ranges(range, tail, acc ++ [range])

  def do_get_ranges(r1..r2 = range, [{s1..s2, d1..d2} | tail], acc) when r1 >= s1 and r2 > s2 do
    first_range = (r1 - s1 + d1)..d2
    second_range = (s2 + 1)..r2

    do_get_ranges(range, tail, acc ++ [first_range, second_range])
  end

  def do_get_ranges(r1..r2 = range, [{s1..s2, d1..d2} | tail], acc) when r1 >= s1 and r2 <= s2 do
    first_range = (r1 - s1 + d1)..(d2 - (s2 - r2))

    do_get_ranges(range, tail, acc ++ [first_range])
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

  def do_get_ranges(range, [_ | tail], acc), do: do_get_ranges(range, tail, acc ++ [range])

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
