"lib/day15/input.txt"
|> File.read!()
|> Day15.PartOne.run()
|> IO.inspect(label: "PART ONE ANSWER")

"lib/day15/input.txt"
|> File.read!()
|> Day15.PartTwo.run()
|> IO.inspect(label: "PART TWO ANSWER")
