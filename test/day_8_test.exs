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
end
