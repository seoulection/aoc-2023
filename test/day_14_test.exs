defmodule Day14Test do
  use ExUnit.Case

  test "part 1 passes" do
    assert 136 =
             """
             O....#....
             O.OO#....#
             .....##...
             OO.#O....O
             .O.....O#.
             O.#..O.#.#
             ..O..#O..O
             .......O..
             #....###..
             #OO..#....
             """
             |> Day14.PartOne.run()
  end

  test "part 3 passes" do
    assert 64 =
             """
             O....#....
             O.OO#....#
             .....##...
             OO.#O....O
             .O.....O#.
             O.#..O.#.#
             ..O..#O..O
             .......O..
             #....###..
             #OO..#....
             """
             |> Day14.PartTwo.run()
  end
end
