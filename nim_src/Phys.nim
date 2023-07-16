##  Port of the GBDK simple_physics demo

import gbdk/[
  input, video, io, interrupts
]

proc `+=`(x: var uint16, y: int16) =
  ## helper, i guess
  if (y < 0):
    x = x - uint16(-y)
  else:
    x = x + uint16(y)

# define graphics

type SpriteGfxIndex = enum
  gfxOne
  gfxTwo
  gfxThree
  gfxFour

const SpriteGfx = [
  gfxOne: [
    0x3C'u8, 0x3C'u8, 0x42'u8, 0x7E'u8, 0x99'u8, 0xFF'u8, 0xA9'u8, 0xFF'u8,
    0x89'u8, 0xFF'u8, 0x89'u8, 0xFF'u8, 0x42'u8, 0x7E'u8, 0x3C'u8, 0x3C'u8
  ],
  gfxTwo: [
    0x3C'u8, 0x3C'u8, 0x42'u8, 0x7E'u8, 0xB9'u8, 0xFF'u8, 0x89'u8, 0xFF'u8,
    0x91'u8, 0xFF'u8, 0xB9'u8, 0xFF'u8, 0x42'u8, 0x7E'u8, 0x3C'u8, 0x3C'u8
  ],
  gfxThree: [
    0x3C'u8, 0x3C'u8, 0x42'u8, 0x7E'u8, 0x99'u8, 0xFF'u8, 0x89'u8, 0xFF'u8,
    0x99'u8, 0xFF'u8, 0x89'u8, 0xFF'u8, 0x5A'u8, 0x7E'u8, 0x3C'u8, 0x3C'u8,
  ],
  gfxFour: [
    0x3C'u8, 0x3C'u8, 0x42'u8, 0x7E'u8, 0xA9'u8, 0xFF'u8, 0xA9'u8, 0xFF'u8,
    0xB9'u8, 0xFF'u8, 0x89'u8, 0xFF'u8, 0x42'u8, 0x7E'u8, 0x3C'u8, 0x3C'u8
  ]
]

var joyPads = Joypads()

var posX, posY: uint16
var spdX, spdY: int16
var jumpCounter: int

when isMainModule:
  BgpReg = 0xe4; Obp0Reg = 0xe4; Obp1Reg = 0xe4

  SpriteGfx[gfxOne].setSpriteData(0, SpriteGfx.len)
  setSpriteTile(0, 0)

  LcdcReg = {lcdcBgOn, lcdcObjOn, lcdcOn, lcdcWin9c00}

  discard joyPads.joypadInit(1)

  posX = 64 shl 4
  posY = 64 shl 4
  spdX = 0
  spdY = 0

  jumpCounter = 0

  while true:
    joyPads.joypadEx()

    # accelerate up & down
    if jUp in joypads.joy0:
      spdY -= 2
      if (spdY < -64): spdY = -64
    elif jDown in joypads.joy0:
      spdY += 2
      if (spdY > 64): spdY = 64

    # accelerate left & right
    if jLeft in joypads.joy0:
      spdX -= 2
      if (spdX < -64): spdX = -64
    elif jRight in joypads.joy0:
      spdX += 2
      if (spdY > 64): spdX = 64

    # jump
    if jA in joypads.joy0 and jumpCounter == 0:
      jumpCounter = 3

    if jumpCounter > 0:
      spdY -= 8
      if (spdY < -32): spdY = -32
      jumpCounter -= 1


    posX += spdX
    posY += spdY

    moveSprite(0, uint8(posX shr 4), uint8(posY shr 4))

    if (spdX > 0): spdX -= 1 elif (spdX < 0): spdX += 1
    if (spdY > 0): spdY -= 1 elif (spdY < 0): spdY += 1

    waitVblDone()
