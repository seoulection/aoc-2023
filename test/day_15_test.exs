defmodule Day15Test do
  use ExUnit.Case

  @input "rn=1,cm-,qp=3,cm=2,qp-,pc=4,ot=9,ab=5,pc-,pc=6,ot=7"

  test "part 1 passes" do
    assert 1320 = Day15.PartOne.run(@input)
  end

  test "part 2 passes" do
    assert 145 = Day15.PartTwo.run(@input)
  end
end
