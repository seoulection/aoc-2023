defmodule Day6Test do
  use ExUnit.Case

  test "part 1 passes" do
    assert 288 =
             """
             Time:      7  15   30
             Distance:  9  40  200
             """
             |> Day6.PartOne.run()
  end

  test "part 2 passes" do
    assert 71503 =
             """
             Time:      7  15   30
             Distance:  9  40  200
             """
             |> Day6.PartTwo.run()
  end
end
