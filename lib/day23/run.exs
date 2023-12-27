"lib/day23/input.txt"
|> File.read!()
|> Day23.PartOne.run()
|> IO.inspect(label: "PART ONE ANSWER")

"lib/day23/input.txt"
|> File.read!()
|> Day23.PartTwo.run()
|> IO.inspect(label: "PART TWO ANSWER")
