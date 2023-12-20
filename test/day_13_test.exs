defmodule Day13Test do
  use ExUnit.Case

  test "part 1 passes" do
    assert 405 =
             """
             #.##..##.
             ..#.##.#.
             ##......#
             ##......#
             ..#.##.#.
             ..##..##.
             #.#.##.#.

             #...##..#
             #....#..#
             ..##..###
             #####.##.
             #####.##.
             ..##..###
             #....#..#
             """
             |> Day13.PartOne.run()
  end
end
