"lib/day3/input.txt"
|> File.read!()
|> Day3.PartOne.run()
|> IO.inspect(label: "PART ONE ANSWER")

"lib/day3/input.txt"
|> File.read!()
|> Day3.PartTwo.run()
|> IO.inspect(label: "PART TWO ANSWER")
