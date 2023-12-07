"lib/day5/input.txt"
|> File.read!()
|> Day5.PartOne.run()
|> IO.inspect(label: "PART ONE ANSWER")

"lib/day5/input.txt"
|> File.read!()
|> Day5.PartTwo.run()
|> IO.inspect(label: "PART TWO ANSWER")
