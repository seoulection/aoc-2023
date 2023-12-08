defmodule Day7Test do
  use ExUnit.Case

  test "part 1 passes" do
    assert 6440 =
             """
             32T3K 765
             T55J5 684
             KK677 28
             KTJJT 220
             QQQJA 483
             """
             |> Day7.PartOne.run()
  end
end
