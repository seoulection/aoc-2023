defmodule Day5.PartOne do
  def run(input) do
    [seeds, _ | tail] = Helpers.parse(input)

    seeds = parse_seeds(seeds)

    almanac = create_almanac(tail)

    Enum.reduce(seeds, 0, fn seed, acc ->
      location =
        seed
        |> find("seed-to-soil", almanac)
        |> find("soil-to-fertilizer", almanac)
        |> find("fertilizer-to-water", almanac)
        |> find("water-to-light", almanac)
        |> find("light-to-temperature", almanac)
        |> find("temperature-to-humidity", almanac)
        |> find("humidity-to-location", almanac)

      case acc do
        0 ->
          location

        _ ->
          if location < acc do
            location
          else
            acc
          end
      end
    end)
  end

  defp find(val, key, almanac) do
    almanac
    |> Map.get(key)
    |> Enum.reduce_while(val, fn map, acc ->
      source = Map.get(map, :source)
      offset = Map.get(map, :offset)

      if val >= source && val < source + offset do
        destination = Map.get(map, :destination) + val - source

        {:halt, destination}
      else
        {:cont, acc}
      end
    end)
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

      places =
        Enum.reduce(values, [], fn [d, s, l], acc ->
          acc ++
            [
              %{
                source: s,
                destination: d,
                offset: l
              }
            ]
        end)

      Map.put(acc, key, places)
    end)
  end
end
