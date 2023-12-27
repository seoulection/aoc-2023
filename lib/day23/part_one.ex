defmodule Day23.PartOne do
  def run(input) do
    {start, target, map} = parse_input(input)

    start
    |> build_graph(start, target, map, 0, MapSet.new(), Graph.new())
    |> get_longest_path(start, target)
  end

  defp get_longest_path(graph, start, target) do
    graph
    |> Graph.get_paths(start, target)
    |> Enum.map(&Enum.chunk_every(&1, 2, 1, :discard))
    |> Enum.map(fn path ->
      path
      |> Enum.map(fn [a, b] ->
        %{weight: weight} = Graph.edge(graph, a, b)

        weight
      end)
      |> Enum.sum()
    end)
    |> Enum.max()
  end

  defp build_graph(curr, prev, target, _map, weight, _set, graph) when curr == target,
    do: Graph.add_edge(graph, prev, curr, weight: weight)

  defp build_graph(curr, prev, target, map, weight, set, graph) do
    set = MapSet.put(set, curr)

    curr
    |> scan_position(map, set)
    |> case do
      [] ->
        graph

      [next] ->
        build_graph(next, prev, target, map, weight + 1, set, graph)

      nexts ->
        graph
        |> Graph.add_edge(prev, curr, weight: weight)
        |> then(fn graph ->
          Enum.reduce(nexts, graph, &build_graph(&1, curr, target, map, 1, set, &2))
        end)
    end
  end

  defp scan_position({row, col} = coords, map, set) do
    map
    |> Map.get(coords)
    |> case do
      "#" ->
        []

      ">" ->
        [{row, col + 1}]

      "v" ->
        [{row + 1, col}]

      "<" ->
        [{row, col - 1}]

      _ ->
        [
          {row + 1, col},
          {row - 1, col},
          {row, col + 1},
          {row, col - 1}
        ]
    end
    |> Enum.reject(&is_nil(Map.get(map, &1)))
    |> Enum.reject(&(Map.get(map, &1) == "#"))
    |> Enum.reject(&MapSet.member?(set, &1))
  end

  defp parse_input(input) do
    [line | _] = strs = Helpers.parse(input)

    map =
      strs
      |> Enum.with_index()
      |> Enum.flat_map(fn {str, i1} ->
        str
        |> String.graphemes()
        |> Enum.with_index()
        |> Enum.map(fn {val, i2} -> {{i1, i2}, val} end)
      end)
      |> Map.new()

    start = {0, 1}
    target = {Enum.count(strs) - 1, String.length(line) - 2}

    {start, target, map}
  end
end
