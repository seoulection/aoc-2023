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

  test "part 2 passes" do
    assert 400 =
             """
             #.##..##.
             ..#.##.#.
             ##......#
             ##......#
             ..#.##.#.
             ..##..##.
             #.#.##.#.
             """
             |> Day13.PartTwo.run()
  end
end
