defmodule Day3Test do
  use ExUnit.Case

  test "part 1 passes" do
    assert 4361 =
             """
             467..114..
             ...*......
             ..35..633.
             ......#...
             617*......
             .....+.58.
             ..592.....
             ......755.
             ...$.*....
             .664.598..
             """
             |> Day3.PartOne.run()
  end
end
