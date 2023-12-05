"lib/day4/input.txt"
|> File.read!()
|> Day4.PartOne.run()
|> IO.inspect(label: "PART ONE ANSWER")

"lib/day4/input.txt"
|> File.read!()
|> Day4.PartTwo.run()
|> IO.inspect(label: "PART TWO ANSWER")
