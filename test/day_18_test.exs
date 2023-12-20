defmodule Day18Test do
  use ExUnit.Case

  @input """
  R 6 (#70c710)
  D 5 (#0dc571)
  L 2 (#5713f0)
  D 2 (#d2c081)
  R 2 (#59c680)
  D 2 (#411b91)
  L 5 (#8ceee2)
  U 2 (#caa173)
  L 1 (#1b58a2)
  U 2 (#caa171)
  R 2 (#7807d2)
  U 3 (#a77fa3)
  L 2 (#015232)
  U 2 (#7a21e3)
  """

  test "part 1 passes" do
    assert 62 = Day18.PartOne.run(@input)
  end

  test "part 2 passes" do
    assert 952_408_144_115 = Day18.PartTwo.run(@input)
  end
end
