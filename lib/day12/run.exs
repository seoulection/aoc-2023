"lib/day12/input.txt"
|> File.read!()
|> Day12.PartOne.run()
|> IO.inspect(label: "PART ONE ANSWER")

"lib/day12/input.txt"
|> File.read!()
|> Day12.PartTwo.run()
|> IO.inspect(label: "PART TWO ANSWER")
