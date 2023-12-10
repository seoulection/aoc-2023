"lib/day8/input.txt"
|> File.read!()
|> Day8.PartOne.run()
|> IO.inspect(label: "PART ONE ANSWER")

"lib/day8/input.txt"
|> File.read!()
|> Day8.PartTwo.run()
|> IO.inspect(label: "PART TWO ANSWER")
