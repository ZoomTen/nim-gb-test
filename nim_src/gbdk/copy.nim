{.pragma: gb, header: "<gb/gb.h>".}
{.warning[UnusedImport]: off.}
{.hint[XDeclaredButNotUsed]: off.}

proc hiRamCpy*(dest: uint8, source: pointer, n: uint8) {.importc: "hiramcpy", gb.}
template hiRamCpy*[T](source: T, n: int, dest: uint16) = ##[
    Copies data from somewhere in the lower address space to part of hi-ram.
    
    @param dst		Offset in high ram (0xFF00 and above) to copy to.
    @param src		Area to copy from
    @param n		Number of bytes to copy.
]##
    when (dest < 0xff00) and (dest > 0x100):
        {.error: "Invalid destination for HRAM copy".}
  const hramDest = uint8(dest and 0xff)
    hiRamCpy(hramDest, unsafeAddr source, uint8(n))
