defmodule Day7.PartOne do
  @high 1
  @one_pair 2
  @two_pair 3
  @three_kind 4
  @full_house 5
  @four_kind 6
  @five_kind 7

  def run(input) do
    map =
      input
      |> Helpers.parse()
      |> convert_faces()
      |> create_map()

    map
    |> Map.keys()
    |> Enum.group_by(&determine_hand_score/1)
    |> Enum.reduce([], fn {_, v}, acc ->
      acc ++ Enum.sort(v)
    end)
    |> Enum.with_index(fn e, i -> {e, i + 1} end)
    |> Enum.reduce(0, fn {key, rank}, acc ->
      acc + Map.get(map, key) * rank
    end)
  end

  defp create_map(parsed_input) do
    Enum.reduce(parsed_input, %{}, fn input, acc ->
      [key, str_val] = String.split(input, " ")

      {num, _} = Integer.parse(str_val)

      Map.put(acc, key, num)
    end)
  end

  defp convert_faces(input) do
    Enum.map(input, fn str ->
      str
      |> String.replace("A", "E")
      |> String.replace("K", "D")
      |> String.replace("Q", "C")
      |> String.replace("J", "B")
      |> String.replace("T", "A")
    end)
  end

  defp determine_hand_score(hand) do
    hand
    |> String.split("", trim: true)
    |> Enum.frequencies()
    |> Map.values()
    |> Enum.sort()
    |> case do
      [1, 1, 1, 1, 1] ->
        @high

      [1, 1, 1, 2] ->
        @one_pair

      [1, 2, 2] ->
        @two_pair

      [1, 1, 3] ->
        @three_kind

      [2, 3] ->
        @full_house

      [1, 4] ->
        @four_kind

      [5] ->
        @five_kind
    end
  end
end
