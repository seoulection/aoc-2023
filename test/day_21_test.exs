defmodule Day21Test do
  use ExUnit.Case

  @input """
  ...........
  .....###.#.
  .###.##..#.
  ..#.#...#..
  ....#.#....
  .##..S####.
  .##..#...#.
  .......##..
  .##.#.####.
  .##..##.##.
  ...........
  """

  test "part 1 passes" do
    assert 16 = Day21.PartOne.run(@input, 6)
  end
end
