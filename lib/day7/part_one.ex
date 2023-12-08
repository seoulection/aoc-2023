defmodule Day7.PartOne do
  @ranks %{
    "A" => 14,
    "K" => 13,
    "Q" => 12,
    "J" => 11,
    "T" => 10,
    "9" => 9,
    "8" => 8,
    "7" => 7,
    "6" => 6,
    "5" => 5,
    "4" => 4,
    "3" => 3,
    "2" => 2,
    "1" => 1
  }

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
      |> create_map()

    map
    |> Map.keys()
    |> Enum.group_by(&determine_hand_score/1)
    |> Enum.reduce()
  end

  defp create_map(parsed_input) do
    Enum.reduce(parsed_input, %{}, fn input, acc ->
      [key, str_val] = String.split(input, " ")

      {num, _} = Integer.parse(str_val)

      Map.put(acc, key, num)
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
        @five_find
    end
  end
end
