##  Port of the GBDK scroller demo.

import gbdk/[
  print, video, misc, io, interrupts
]

import strutils

const
  ScrollPos = 15
  ScrollPixStart = (ScrollPos * 8) - 1
  ScrollPixEnd = ((ScrollPos + 1) * 8) - 1
  ScrollSpeed = 1

var
  scrollOffset: uint8 = 0
  charIdx = 0
  vramAddr = getBkgXyAddr(20, ScrollPos)

let
  base = cast[int](vramAddr) and 0xffe0
  lim = base + 0x1f

const scrollTxt: cstring = """
This is a text scroller demo for GBDK-2020.
You can use ideas, that are shown in this demo, to make
different parallax effects, scrolling of tilemaps which are
larger than 32x32 tiles and TEXT SCROLLERS, of course!
Need to write something else to make this text longer than 256
characters.
""".strip()

proc scanlineIsr() =
  # set SCX for certain scanlines
  case LycReg
  of 0:
    ScxReg = 0
    LycReg = ScrollPixStart
  of ScrollPixStart:
    ScxReg = scrollOffset
    LycReg = ScrollPixEnd
  of ScrollPixEnd:
    ScxReg = 0
    LycReg = 0
  else:
    discard

proc setupScanlineIsr() {.inline.} =
  # needs to be its own function otherwise
  # the CRITICAL{} annotation will be inserted
  # at the wrong place!
  critical:
    StatReg = StatReg + {statLyc}
    LycReg = 0
    addLcdHandler(scanlineIsr)

when isMainModule:
  printf "Scrolling %d chars", scrollTxt.len

  setVramByte(vramAddr, adjustAscii(scrollTxt[charIdx]))

  setupScanlineIsr()
  setInterrupts {intVBlank, intLcd}

  while true:
    scrollOffset += ScrollSpeed

    if ((scrollOffset and 7) == 0):
      if (charIdx < scrollTxt.len-1):
        charIdx += 1
      else: # wrap around
        charIdx = 0

      # put character
      if (cast[int](vramAddr) == lim):
        vramAddr = cast[ptr uint8](base)
      else:
        vramAddr = cast[ptr uint8](cast[int](vramAddr) + 1)

      setVramByte(vramAddr, adjustAscii(scrollTxt[charIdx]))

    # finish frame
    waitVblDone()
