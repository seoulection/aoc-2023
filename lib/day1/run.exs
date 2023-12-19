"lib/day1/input.txt"
|> File.read!()
|> Day1.PartOne.run()
|> IO.inspect(label: "PART ONE ANSWER")

"lib/day1/input.txt"
|> File.read!()
|> Day1.PartTwo.run()
|> IO.inspect(label: "PART TWO ANSWER")
