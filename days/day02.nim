import std/strutils

const
  numRed = 12
  numGreen = 13
  numBlue = 14

type Bag = object
  red, green, blue: int

proc parseGame(game: string): seq[Bag] =
  for round in game.split("; "):
    var bag = Bag()
    let colors = round.split(", ")
    for color in colors:
      let parts = color.split(" ")
      let num = parseInt(parts[0])
      let name = parts[1]
      case name
      of "red": bag.red = num
      of "green": bag.green = num
      of "blue": bag.blue = num
      else: discard
    result.add(bag)

proc part1*(input: string): string =
  var id = 1
  var sum = 0
  for game in input.splitLines:
    if game.len == 0:
      continue
    let game = game.split(": ")[1]
    let bags = parseGame(game)
    var possible = true
    for bag in bags:
      if bag.red > numRed or bag.green > numGreen or bag.blue > numBlue:
        possible = false
        break
    if possible:
      sum += id
    inc id
  $sum

proc part2*(input: string): string =
  var sum = 0
  for game in input.splitLines:
    if game.len == 0:
      continue
    let game = game.split(": ")[1]
    let bags = parseGame(game)
    var maxBag = Bag()
    for bag in bags:
      maxBag.red = max(maxBag.red, bag.red)
      maxBag.green = max(maxBag.green, bag.green)
      maxBag.blue = max(maxBag.blue, bag.blue)
    sum += maxBag.red * maxBag.green * maxBag.blue
  $sum

when isMainModule:
  echo parseGame("3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green")
