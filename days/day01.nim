import std/algorithm
import std/pegs
import std/strutils

type
  Nums = tuple[first: int, last: int]

proc getFirstLast(input: string): Nums =
  for c in input:
    case c
    of '0'..'9':
      result.first = ord(c) - ord('0')
      break
    else:
      discard

  for c in input.reversed:
    case c
    of '0'..'9':
      result.last = ord(c) - ord('0')
      break
    else:
      discard

proc part1*(input: string): string =
  var acc = 0
  for line in input.splitLines:
    let (first, last) = getFirstLast(line)
    acc += first * 10 + last

  $acc

let patt = peg"""
  digit <- @ {rawdigit / textdigit}
  rawdigit <- [0-9]
  textdigit <- "one" / "two" / "three" / "four" / "five" / "six" / "seven" / "eight" / "nine"
"""

let revPatt = peg"""
  digit <- @ {rawdigit / textdigit}
  rawdigit <- [0-9]
  textdigit <- "eno" / "owt" / "eerht" / "ruof" / "evif" / "xis" / "neves" / "thgie" / "enin"
"""

proc firstMatch(s: string; p: Peg): string =
  if s =~ p:
    matches[0]
  else:
    ""

proc digitNum(s: string): int =
  if s.len == 1:
    return ord(s[0]) - ord('0')
  case s
  of "one": 1
  of "two": 2
  of "three": 3
  of "four": 4
  of "five": 5
  of "six": 6
  of "seven": 7
  of "eight": 8
  of "nine": 9
  else: 0

proc reversed(x: string): string =
  var res = newString(x.len)
  for i in 0..<x.len:
    res[i] = x[x.len - i - 1]

  res

proc part2*(input: string): string =
  var acc = 0
  for line in input.splitLines:
    if line.len == 0:
      break
    let matches = line.findAll(patt)
    let first = matches[0].firstMatch(patt).digitNum
    let last = line.reversed.firstMatch(revPatt).reversed.digitNum
    acc += first * 10 + last

  $acc
