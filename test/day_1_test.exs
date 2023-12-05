defmodule Day1Test do
  use ExUnit.Case

  test "part 1 passes" do
    assert 142 =
             """
             1abc2
             pqr3stu8vwx
             a1b2c3d4e5f
             treb7uchet
             """
             |> Day1.PartOne.run()
  end

  test "part 2 passes" do
    assert 281 =
             """
             two1nine
             eightwothree
             abcone2threexyz
             xtwone3four
             4nineeightseven2
             zoneight234
             7pqrstsixteen
             """
             |> Day1.PartTwo.run()
  end
end
