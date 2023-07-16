## Testing out the first few GBDK bindings

import gbdk/[
    print, misc, io
]

proc fibonacci(): uint64 =
  result = 0
  var
    n1: uint64 = 0
    n2: uint64 = 1
  for i in 1..22:
    printf "seq%03d -> %d\n", i, result
    n1 = n2
    n2 = result
    result = n1 + n2
    delay 100

func adjustAscii(c: char): uint8 {.inline.} =
  uint8(c) - 0x20

let ab = [10, 20, 30, 40, 50, 64]

printf "%d\n", fibonacci()

for i in ab:
  printf "%d ", i

printf "\n\n"

var i: uint16

let text: cstring = "Ezpz lemon squeezy"

while i < uint8(text.len):
  Scrn0[i] = adjustAscii(text[i])
  i += 1
  delay 35
