defmodule Day16Test do
  use ExUnit.Case

  test "part 1 passes" do
    input = get_input()

    assert 46 = Day16.PartOne.run(input)
  end

  test "part 2 passes" do
    input = get_input()

    assert 51 = Day16.PartTwo.run(input)
  end

  defp get_input do
    File.read!("lib/day16/test_input.txt")
  end
end
