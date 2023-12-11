import std/os
import std/strformat
import std/sugar

import pkg/argparse

from days/day01 import nil

proc implementedDay(msg: string; input: string; part1, part2: static[string -> string]) =
  let text = readFile(input)
  echo msg
  echo "  Part 1: ", part1(text)
  echo "  Part 2: ", part2(text)

proc doDay(day: int, input: string) =
  let msg = fmt"Day {day:2}: "
  case day
  of 1: implementedDay(msg, input, day01.part1, day01.part2)
  else:
    discard

var p = newParser:
  option("-d", "--day", help="day to run", default=some("all"))
  arg("input", help="input file", default=some(""))

let args = try:
  p.parse
except UsageError as e:
  stderr.writeLine e.msg
  quit(1)
except ShortCircuit:
  echo p.help
  quit(0)

if args.day == "all":
  for day in 1..25:
    doDay(day, fmt"input/day{day:0>2}.txt")
else:
  let input = case args.input
    of "": fmt"input/day{args.day:0>2}.txt"
    else: args.input

  doDay(parseInt(args.day), input)
