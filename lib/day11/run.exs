"lib/day11/input.txt"
|> File.read!()
|> Day11.PartOne.run()
|> IO.inspect(label: "PART ONE ANSWER")

"lib/day11/input.txt"
|> File.read!()
|> Day11.PartTwo.run()
|> IO.inspect(label: "PART TWO ANSWER")
