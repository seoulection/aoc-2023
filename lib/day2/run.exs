"lib/day2/input.txt"
|> File.read!()
|> Day2.PartOne.run()
|> IO.inspect(label: "PART ONE ANSWER")

"lib/day2/input.txt"
|> File.read!()
|> Day2.PartTwo.run()
|> IO.inspect(label: "PART TWO ANSWER")
