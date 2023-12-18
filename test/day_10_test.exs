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
end
