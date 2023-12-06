"lib/day6/input.txt"
|> File.read!()
|> Day6.PartOne.run()
|> IO.inspect(label: "PART ONE ANSWER")

"lib/day6/input.txt"
|> File.read!()
|> Day6.PartTwo.run()
|> IO.inspect(label: "PART TWO ANSWER")
