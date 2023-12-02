import std/os

import days/day01

let name = paramStr(1)
echo day01.part1(readFile(name))
echo day01.part2(readFile(name))

