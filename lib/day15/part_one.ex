defmodule Day15.PartOne do
  def run(input) do
    input
    |> Helpers.parse()
    |> List.first()
    |> String.split(",")
    |> Enum.reduce(0, &(&2 + hash(&1)))
  end

  defp hash(str) do
    str
    |> String.to_charlist()
    |> Enum.reduce(0, fn ascii, acc ->
      ascii
      |> Kernel.+(acc)
      |> Kernel.*(17)
      |> rem(256)
    end)
  end
end
