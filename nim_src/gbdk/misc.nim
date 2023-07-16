{.pragma: gb, header: "<gb/gb.h>".}
{.warning[UnusedImport]: off.}
{.hint[XDeclaredButNotUsed]: off.}

import macros

func adjustAscii*(c: char): uint8 {.inline.} = ##[
    Transforms an ASCII character literal into
    the appropriate tile to place in VRAM.
]##
    uint8(c) - 0x20

proc delay*(s: uint16) {.importc, gb.} ##[
    Delays the given number of milliseconds.
    Uses no timers or interrupts, and can be called with
    interrupts disabled.
]##

proc reset*() {.importc, gb.} ##[
    Performs a warm reset by reloading the CPU value
    then jumping to the start of crt0 (0x0150)
]##

proc itoa*(n: int, s: cstring, radix: uint8): cstring {.importc,
        header: "<stdlib.h>".}
template itoa*(s: openArray[uint8], n: int, radix: uint8): cstring = ##[
  Converts an integer to a string.
]##
    itoa(n, cast[cstring](addr s), radix)

# code from exelotl's Natu
# Zlib
template incBin*(filename: static string): untyped = ##[
    Lets you include files directly into the ROM.

    .. important::
        Use `const` with this, not `let`! `let` will copy
        the file on memory (which is obviously horrible as far as an
        8K machine goes)
]##
    const data = static:
        const str = staticRead(getProjectPath() & "/" & filename)
        var arr: array[str.len, uint8]
        for i, c in str:
            arr[i] = uint8(c)
        arr
    data
