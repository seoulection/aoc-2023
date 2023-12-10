"lib/day7/input.txt"
|> File.read!()
|> Day7.PartOne.run()
|> IO.inspect(label: "PART ONE ANSWER")

"lib/day7/input.txt"
|> File.read!()
|> Day7.PartTwo.run()
|> IO.inspect(label: "PART TWO ANSWER")
