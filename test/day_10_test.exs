defmodule Day10Test do
  use ExUnit.Case

  test "part 1 passes" do
    assert 4 =
             """
             .....
             .S-7.
             .|.|.
             .L-J.
             .....
             """
             |> Day10.PartOne.run()
  end

  test "part 2-1 passes" do
    assert 4 =
             """
             ...........
             .S-------7.
             .|F-----7|.
             .||.....||.
             .||.....||.
             .|L-7.F-J|.
             .|..|.|..|.
             .L--J.L--J.
             ...........
             """
             |> Day10.PartTwo.run()
  end

  test "part 2-2 passes" do
    assert 10 =
             """
             FF7FSF7F7F7F7F7F---7
             L|LJ||||||||||||F--J
             FL-7LJLJ||||||LJL-77
             F--JF--7||LJLJ7F7FJ-
             L---JF-JLJ.||-FJLJJ7
             |F|F-JF---7F7-L7L|7|
             |FFJF7L7F-JF7|JL---7
             7-L-JL7||F7|L7F-7F7|
             L.L7LFJ|||||FJL7||LJ
             L7JLJL-JLJLJL--JLJ.L
             """
             |> Day10.PartTwo.run()
  end
end
