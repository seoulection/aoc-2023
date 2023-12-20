defmodule Day18.PartOne do
  def run(input) do
    polygon =
      input
      |> Helpers.parse()
      |> Enum.map(&String.split(&1, " "))
      |> Enum.reduce([{0, 0}], fn [dir, amount_str, _], [last_coords | _] = acc ->
        amount = parse_int(amount_str)

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

  def parse_int(str) do
    str
    |> Integer.parse()
    |> then(&elem(&1, 0))
  end
end
