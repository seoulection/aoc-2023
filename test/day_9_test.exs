defmodule Day9Test do
  use ExUnit.Case

  test "part 1 passes" do
    assert 114 =
             """
             0 3 6 9 12 15
             1 3 6 10 15 21
             10 13 16 21 30 45
             """
             |> Day9.PartOne.run()
  end

  test "part 2 passes" do
    assert 2 =
             """
             0 3 6 9 12 15
             1 3 6 10 15 21
             10 13 16 21 30 45
             """
             |> Day9.PartTwo.run()
  end
end
