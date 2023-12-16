"lib/day9/input.txt"
|> File.read!()
|> Day9.PartOne.run()
|> IO.inspect(label: "PART ONE ANSWER")

"lib/day9/input.txt"
|> File.read!()
|> Day9.PartTwo.run()
|> IO.inspect(label: "PART TWO ANSWER")
