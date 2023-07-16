{.pragma: gb, header: "<gb/gb.h>".}
{.warning[UnusedImport]: off.}
{.hint[XDeclaredButNotUsed]: off.}

##[
  This module is NOT where you'll find VRAM addresses---this is for
  manipulating VRAM through abstractions and such. For addresses, have
  a look at `io`_.
]##

type SpriteRange = range[0'u8..39'u8]
type BgSizeRange = range[1'u8..32'u8]

proc setSpriteData*(first: uint8, n: uint8,
    data: ptr uint8) {.importc: "set_sprite_data", gb.}
template setSpriteData*(data: openArray[uint8], first: uint8, n: uint8) = ##[
    Sets VRAM Tile Pattern data for Sprites

    Params:
      - `first` Index of the first tile to write
      - `n` Number of tiles to write
      - `data` (2 bpp) source Tile Pattern data

    Writes `n` tiles to VRAM starting at `first`, tile data
    is sourced from `data`. Each Tile is 16 bytes in size (8x8 pixels, 2 bits-per-pixel).

    .. note::
      Sprite Tiles 128-255 share the same memory region as Background Tiles 128-255.

    .. note::
      GBC only: `VbkReg`_ determines which bank of Background tile patterns are written to.
]##
  setSpriteData(first, n, cast[ptr uint8](unsafeAddr data))

proc setWinData*(first: uint8, n: uint8,
    data: ptr uint8) {.importc: "set_win_data", gb.}
template setWinData*(data: openArray[uint8], first: uint8, n: uint8) =
  setWinData(first, n, cast[ptr uint8](unsafeAddr data))

proc setSpriteTile*(nb: SpriteRange,
    tile: uint8) {.importc: "set_sprite_tile", gb.} ##[
    Sets sprite number `nb` in the OAM to display tile number `tile`.

    Params:
      - `nb` Sprite number
      - `tile` Selects a tile (0 - 255) from memory at 8000h - 8FFFh. In CGB
        Mode this could be either in VRAM Bank 0 or 1, depending on Bit 3 of
        the OAM Attribute Flag (see `setSpriteProp`_)

    In 8x16 mode:
      - The sprite will also display the next tile (`tile` + 1)
        directly below (y + 8) the first tile.
      - The lower bit of the tile number is ignored:
        the upper 8x8 tile is (`tile` & 0xFE), and
        the lower 8x8 tile is (`tile` | 0x01).
]##

proc moveSprite*(n: SpriteRange, x, y: uint8) {.importc: "move_sprite", gb.} ##[
    Moves sprite number `nb` to the `x`, `y` position on the screen.

    Params:
      - `nb` Sprite number
      - `x` X Position. Specifies the sprites horizontal position on the screen (minus 8).
        An offscreen value (X=0 or X>=168) hides the sprite, but the sprite
        still affects the priority ordering - a better way to hide a sprite is to set
        its Y-coordinate offscreen.
      - `y` Y Position. Specifies the sprites vertical position on the screen (minus 16).
        An offscreen value (for example, Y=0 or Y>=160) hides the sprite.

    Moving the sprite to 0,0 (or similar off-screen location) will hide it.
]##

proc getBkgXyAddr*(x, y: uint8): ptr uint8 {.importc: "get_bkg_xy_addr", gb.} ##[
    Get address of X,Y tile of background map
]##

proc setVramByte*(dest: ptr uint8, v: uint8) {.importc: "set_vram_byte", gb.} ##[
    Set byte in vram at given memory location
    
    Params:
      - `addr` address to write to
      - `v` value
]##

proc setBkgData*(first, numTiles: uint8,
    data: ptr uint8) {.importc: "set_bkg_data", gb.}
template setBkgData*(data: openArray[uint8], first, numTiles: uint8) = ##[
    Sets VRAM Tile Pattern data for the Background / Window

    Params:
      - `first` Index of the first tile to write
      - `numTiles`  Number of tiles to write
      - `data` (2 bpp) source tile data

    Writes `numTiles` tiles to VRAM starting at `first`, tile data
    is sourced from `data`. Each Tile is 16 bytes in size (8x8 pixels, 2 bits-per-pixel).

    .. note::
      Sprite Tiles 128-255 share the same memory region as Background Tiles 128-255.

    .. note::
      GBC only: @ref VBK_REG determines which bank of Background tile patterns are written to.

    See also:
      - `setWinData`_
      - `setTileData`_
]##
  setBkgData(first, numTiles, cast[ptr uint8](unsafeAddr data))
template setBkgData*(data: ptr uint8, first, numTiles: uint8) =
  setBkgData(first, numTiles, data)

proc setBkgTiles*(x, y: uint8, w, h: BgSizeRange,
    data: ptr uint8) {.importc: "set_bkg_tiles", gb.}
template setBkgTiles*(data: openArray[uint8], x, y, w, h: uint8) = ##[
    Sets a rectangular region of Background Tile Map.

    Params:
      - `x` X start position in bgmap tile coords.
      - `y` Y start position in bgmap tile coords
      - `w` Width of area to set in tiles
      - `h` Height of area to set in tiles
      - `tiles` source tile map data

    Entries are copied from map at `tiles` to the Background Tile Map starting at
    `x`, `y` writing across for `w` tiles and down for `h` tiles.

    Use `setBkgSubmap`_ instead when:
      - Source map is wider than 32 tiles.
      - Writing a width that does not match the source map width and more
        than one row high at a time.

    One byte per source tile map entry.

    Writes that exceed coordinate 31 on the x or y axis will wrap around to
    the Left and Top edges. (maybe)

    .. note::
      Patterns 128-255 overlap with patterns 128-255 of the sprite Tile Pattern table.

    .. note::
      GBC only: `VbkReg`_ determines whether Tile Numbers or Tile Attributes get set.

    GBC Tile Attributes are defined as:
      - Bit 7 - Priority flag. When this is set, it puts the tile above the sprites
                with colour 0 being transparent.
                - 0: Below sprites
                - 1: Above sprites
                - Note: @ref SHOW_BKG needs to be set for these priorities to take place.
      - Bit 6 - Vertical flip. Dictates which way up the tile is drawn vertically.
                - 0: Normal
                - 1: Flipped Vertically
      - Bit 5 - Horizontal flip. Dictates which way up the tile is drawn horizontally.
                - 0: Normal
                - 1: Flipped Horizontally
      - Bit 4 - Not used
      - Bit 3 - Character Bank specification. Dictates from which bank of
                Background Tile Patterns the tile is taken.
                - 0: Bank 0
                - 1: Bank 1
      - Bit 2 - See bit 0.
      - Bit 1 - See bit 0.
      - Bit 0 - Bits 0-2 indicate which of the 7 BKG colour palettes the tile is
                assigned.

    See also:
      - `setBkgData`_
      - `setBkgSubmap`_
      - `setWinTiles`_
      - `setTiles`_
]##
  setBkgTiles(x, y, w, h, cast[ptr uint8](unsafeAddr data))

proc setWinTiles*(x, y, w, h: uint8, data: ptr uint8) {.importc: "set_win_tiles", gb.}
template setWinTiles*(data: openArray[uint8], x, y, w, h: uint8) =
  setWinTiles(x, y, w, h, cast[ptr uint8](unsafeAddr data))

proc getBkgTileXY*(x, y: uint8): uint8 {.importc: "get_bkg_tile_xy", gb.} ##[
    Get single tile t on background layer at x,y

    Returns: Tile index
]##

proc setBkgTileXY*(x, y, t: uint8): ptr uint8 {.importc: "set_bkg_tile_xy", gb.} ##[
    Set single tile t on background layer at x,y
    
    Returns: the address of tile, so you may use faster set_vram_byte() later
]##

# TODO: docs
proc fillBkgRect*(x, y, w, h, t: uint8) {.importc: "fill_bkg_rect", gb.} ##[
  Fills a rectangular region of Tile Map entries for the Background layer with tile.

    @param x      X Start position in Background Map tile coordinates. Range 0 - 31
    @param y      Y Start position in Background Map tile coordinates. Range 0 - 31
    @param w      Width of area to set in tiles. Range 0 - 31
    @param h      Height of area to set in tiles. Range 0 - 31
    @param tile   Fill value
]##

# TODO: docs
proc fillWinRect*(x, y, w, h, t: uint8) {.importc: "fill_win_rect", gb.} ##[
  Fills a rectangular region of Tile Map entries for the Window layer with tile.

    @param x      X Start position in Window Map tile coordinates. Range 0 - 31
    @param y      Y Start position in Window Map tile coordinates. Range 0 - 31
    @param w      Width of area to set in tiles. Range 0 - 31
    @param h      Height of area to set in tiles. Range 0 - 31
    @param tile   Fill value
]##

# TODO: docs
proc setBkgBasedTiles*(x, y, w, h: uint8, data: ptr uint8,
    base: uint8) {.importc: "set_bkg_based_tiles", gb.} ##[
  Sets a rectangular region of Background Tile Map.
    The offset value in __base_tile__ is added to
    the tile ID for each map entry.

    @param x      X Start position in Background Map tile coordinates. Range 0 - 31
    @param y      Y Start position in Background Map tile coordinates. Range 0 - 31
    @param w      Width of area to set in tiles. Range 1 - 32
    @param h      Height of area to set in tiles. Range 1 - 32
    @param tiles  Pointer to source tile map data
    @param base_tile Offset each tile ID entry of the source map by this value. Range 1 - 255

    This is identical to @ref set_bkg_tiles() except that it
    adds the __base_tile__ parameter for when a tile map's tiles don't
    start at index zero. (For example, the tiles used by the map
    range from 100 -> 120 in VRAM instead of 0 -> 20).

    @see set_bkg_tiles for more details
]##
