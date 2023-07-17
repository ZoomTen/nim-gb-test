{.pragma: gbhw, header: "<gb/hardware.h>".}
{.warning[UnusedImport]: off.}
{.hint[XDeclaredButNotUsed]: off.}

type
  LcdcFlag* {.size: 1.} = enum
    lcdcBgOn = 0
    lcdcObjOn = 1
    lcdcObj16 = 2   ## 0 = objs are 8x8
    lcdcBg9c00 = 3  ## 0 = bg map is 9800
    lcdcBg8000 = 4  ## 0 = bg tiles is 8800
    lcdcWinOn = 5
    lcdcWin9c00 = 6 ## 0 = win is 9800
    lcdcOn = 7,

  LcdcFlags* = set[LcdcFlag] ##[
    See also:
      - `LcdcReg`_
  ]##

  VbkSelect* {.size: 1.} = enum ##[
    See also:
      - `VbkReg`_
  ]##
    VbkTiles = 0
    VbkAttributes = 1

  StatFlag* {.size: 1.} = enum
    statVbl = 0   ## break on -> 0 = hblank, 1 = vblank
    statBusy = 1  ## used in general
    statLycf = 2  ## LYC status flag
    statMode0 = 3 ## HBlank source
    statMode1 = 4 ## VBlank source
    statMode2 = 5 ## OAM source
    statLyc = 6,  ## LYC = LY

  StatFlags* = set[StatFlag] ##[
    See also:
      - `StatReg`_
  ]##

  AudEnable* = enum ##[
    See also:
      - `Nr52Reg`_
  ]##
    audioOff = 0
    audioOn = 0x80'u8

  AudTermFlag* {.size: 1.} = enum
    # right channels
    aTerm1R = 0
    aTerm2R
    aTerm3R
    aTerm4R
    # left channels
    aTerm1L
    aTerm2L
    aTerm3L
    aTerm4L

  AudTermFlags* = set[AudTermFlag] ##[
    See also:
      - `Nr51Reg`_
  ]##

var
  Vram* {.importc: "_VRAM", gbhw.}: array[0x2000, uint8]                    ##\
    ## VRAM space, spans from 0x8000 to 0x9fff.

  Vram8000* {.importc: "_VRAM8000", gbhw.}: array[0x800, uint8]             ##\
    ## Tileset 0.

  Vram8800* {.importc: "_VRAM8800", gbhw.}: array[0x800, uint8]             ##\
    ## Tileset 1. Shared between the two tileset modes starting at \
    ## tile 0x80.

  Vram9000* {.importc: "_VRAM9000", gbhw.}: array[0x800, uint8]             ##\
    ## Tileset 2.

  Scrn0* {.importc: "_SCRN0", gbhw.}: array[0x400, uint8]                   ##\
    ## BG map 0, corresponds to 0x9800.

  Scrn1* {.importc: "_SCRN1", gbhw.}: array[0x400, uint8]                   ##\
    ## BG map 1, corresponds to 0x9c00.

  ScxReg* {.importc: "SCX_REG", gbhw.}: uint8
  ScyReg* {.importc: "SCY_REG", gbhw.}: uint8

  WxReg* {.importc: "WX_REG", gbhw.}: uint8
  WyReg* {.importc: "WY_REG", gbhw.}: uint8

  StatReg* {.importc: "STAT_REG", gbhw.}: StatFlags
  LycReg* {.importc: "LYC_REG", gbhw.}: uint8

  VbkReg* {.importc: "VBK_REG", gbhw.}: VbkSelect

  BgpReg* {.importc: "BGP_REG", gbhw.}: uint8
  Obp0Reg* {.importc: "OBP0_REG", gbhw.}: uint8
  Obp1Reg* {.importc: "OBP1_REG", gbhw.}: uint8

  LcdcReg* {.importc: "LCDC_REG", gbhw.}: LcdcFlags

  Nr10Reg* {.importc: "NR10_REG", gbhw.}: uint8
  Nr11Reg* {.importc: "NR11_REG", gbhw.}: uint8
  Nr12Reg* {.importc: "NR12_REG", gbhw.}: uint8
  Nr13Reg* {.importc: "NR13_REG", gbhw.}: uint8
  Nr14Reg* {.importc: "NR14_REG", gbhw.}: uint8

  Nr21Reg* {.importc: "NR21_REG", gbhw.}: uint8
  Nr22Reg* {.importc: "NR22_REG", gbhw.}: uint8
  Nr23Reg* {.importc: "NR23_REG", gbhw.}: uint8
  Nr24Reg* {.importc: "NR24_REG", gbhw.}: uint8

  Nr30Reg* {.importc: "NR30_REG", gbhw.}: uint8
  Nr31Reg* {.importc: "NR31_REG", gbhw.}: uint8
  Nr32Reg* {.importc: "NR32_REG", gbhw.}: uint8
  Nr33Reg* {.importc: "NR33_REG", gbhw.}: uint8
  Nr34Reg* {.importc: "NR34_REG", gbhw.}: uint8

  Nr41Reg* {.importc: "NR41_REG", gbhw.}: uint8
  Nr42Reg* {.importc: "NR42_REG", gbhw.}: uint8
  Nr43Reg* {.importc: "NR43_REG", gbhw.}: uint8
  Nr44Reg* {.importc: "NR44_REG", gbhw.}: uint8

  Nr50Reg* {.importc: "NR50_REG", gbhw.}: uint8
  Nr51Reg* {.importc: "NR51_REG", gbhw.}: AudTermFlags
  Nr52Reg* {.importc: "NR52_REG", gbhw.}: AudEnable

  Aud3Wave* {.importc: "AUD3WAVE", gbhw.}: array[0x10, uint8]
