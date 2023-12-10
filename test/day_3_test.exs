defmodule Day3Test do
  use ExUnit.Case

  @input """
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

  test "part 1 passes" do
    assert 4361 = Day3.PartOne.run(@input)
  end

  test "part 2 passes" do
    assert 467_835 = Day3.PartTwo.run(@input)
  end
end
