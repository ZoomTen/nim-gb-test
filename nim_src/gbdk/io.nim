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
