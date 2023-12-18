"lib/day10/input.txt"
|> File.read!()
|> Day10.PartOne.run()
|> IO.inspect(label: "PART ONE ANSWER")

"lib/day10/input.txt"
|> File.read!()
|> Day10.PartTwo.run()
|> IO.inspect(label: "PART TWO ANSWER")
