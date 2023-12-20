defmodule Day12Test do
  use ExUnit.Case

  test "part 1 passes" do
    assert 1 = Day12.PartOne.test("???.### 1,1,3")
    assert 10 = Day12.PartOne.test("?###???????? 3,2,1")
  end
end
