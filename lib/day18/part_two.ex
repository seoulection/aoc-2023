defmodule Day18.PartTwo do
  @hex_mapper %{
    "0" => "R",
    "1" => "D",
    "2" => "L",
    "3" => "U"
  }

  def run(input) do
    polygon =
      input
      |> Helpers.parse()
      |> Enum.map(fn str ->
        str
        |> String.split(" ")
        |> List.last()
        |> String.replace("(#", "")
        |> String.replace(")", "")
      end)
      |> Enum.reduce([{0, 0}], fn hex, [last_coords | _] = acc ->
        {dir, amount} = parse(hex)

        List.flatten([move(dir, amount, last_coords) | acc])
      end)
      |> Enum.reverse()
      |> Enum.uniq()

    Enum.count(polygon) + find_area(polygon)
  end

  defp move("R", amount, {x, y}) do
    Enum.reduce(x..(amount + x), [], fn step, acc ->
      [{step, y} | acc]
    end)
  end

  defp move("D", amount, {x, y}) do
    Enum.reduce(y..(amount + y), [], fn step, acc ->
      [{x, step} | acc]
    end)
  end

  defp move("L", amount, {x, y}) do
    Enum.reduce(x..(x - amount), [], fn step, acc ->
      [{step, y} | acc]
    end)
  end

  defp move("U", amount, {x, y}) do
    Enum.reduce(y..(y - amount), [], fn step, acc ->
      [{x, step} | acc]
    end)
  end

  defp parse(hex) do
    {h1, h2} = String.split_at(hex, 5)

    {Map.get(@hex_mapper, h2), parse_hex(h1)}
  end

  defp parse_hex(hex) do
    hex
    |> Integer.parse(16)
    |> then(&elem(&1, 0))
  end

  defp find_area(list) do
    {start_y, start_x} = List.first(list)
    {last_y, last_x} = List.last(list)
    vertices_count = Enum.count(list)
    sum1 = 0
    sum2 = 0

    {sum1, sum2} = do_find_area(list, sum1, sum2)

    sum1 = sum1 + start_y * last_x
    sum2 = sum2 + start_x * last_y

    area = (abs(sum1 - sum2) / 2) |> trunc()

    b = vertices_count / 2

    i = area - b + 1

    trunc(i)
  end

  defp do_find_area([_ | []], sum1, sum2), do: {sum1, sum2}

  defp do_find_area([{y1, x1} | tail], sum1, sum2) do
    {y2, x2} = List.first(tail)

    do_find_area(tail, sum1 + x1 * y2, sum2 + x2 * y1)
  end
end
