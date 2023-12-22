"lib/day13/input.txt"
|> File.read!()
|> Day13.PartOne.run()
|> IO.inspect(label: "PART ONE ANSWER")

"lib/day13/input.txt"
|> File.read!()
|> Day13.PartTwo.run()
|> IO.inspect(label: "PART TWO ANSWER")
