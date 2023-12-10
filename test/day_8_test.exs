defmodule Day8Test do
  use ExUnit.Case

  test "part 1-0 passes" do
    assert 2 =
             """
             RL

             AAA = (BBB, CCC)
             BBB = (DDD, EEE)
             CCC = (ZZZ, GGG)
             DDD = (DDD, DDD)
             EEE = (EEE, EEE)
             GGG = (GGG, GGG)
             ZZZ = (ZZZ, ZZZ)
             """
             |> Day8.PartOne.run()
  end

  test "part 1-1 passes" do
    assert 6 =
             """
             LLR

             AAA = (BBB, BBB)
             BBB = (AAA, ZZZ)
             ZZZ = (ZZZ, ZZZ)
             """
             |> Day8.PartOne.run()
  end

  test "part 2 passes" do
    assert 6 =
             """
             LR

             11A = (11B, XXX)
             11B = (XXX, 11Z)
             11Z = (11B, XXX)
             22A = (22B, XXX)
             22B = (22C, 22C)
             22C = (22Z, 22Z)
             22Z = (22B, 22B)
             XXX = (XXX, XXX)
             """
             |> Day8.PartTwo.run()
  end
end
