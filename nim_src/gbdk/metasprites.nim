{.pragma: metasprite, header: "<gb/metasprites.h>".}
{.warning[UnusedImport]: off.}
{.hint[XDeclaredButNotUsed]: off.}

type
  Metasprite* {.importc: "metasprite_t", metasprite.} = object
    dy*, dx*: int8
    tile*, props*: uint8
