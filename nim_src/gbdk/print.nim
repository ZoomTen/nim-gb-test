{.pragma: gb, header: "<gb/gb.h>".}
{.pragma: stdio, header: "<stdio.h>".}
{.pragma: emu, header: "<gbdk/emu_debug.h>".}
{.warning[UnusedImport]: off.}
{.hint[XDeclaredButNotUsed]: off.}

proc printf*(s: cstring) {.importc, varargs, stdio.} ##[
    Print the string and arguments given by format to stdout. When called,
    this will load the font to VRAM if not already loaded, and clears the
    screen.

    Params:
        - `format`: The format string as per printf

    Does not return the number of characters printed.

    .. attention::
        Result string MUST BE LESS OR EQUAL THAN 128 BYTES LONG, INCLUDING THE TRAILIG ZERO BYTE!

    Currently supported:
        - `%hx` (char as hex)
        - `%hu` (unsigned char)
        - `%hd` (signed char)
        - `%c` (character)
        - `%u` (unsigned int)
        - `%d` (signed int)
        - `%x` (unsigned int as hex)
        - `%s` (string)

    .. warning::
        To correctly pass chars for printing as chars, they *must*
        be explicitly re-cast as such when calling the function.
]##

proc emuPrintf*(s: cstring) {.importc: "EMU_printf", varargs, emu.} ##[
    Print the string and arguments given by format to the emulator debug message window

    See also:
        - `printf`_

    Does not return the number of characters printed.

    .. attention::
        Result string MUST BE LESS OR EQUAL THAN 128 BYTES LONG, INCLUDING
        THE TRAILING ZERO BYTE!

    .. warning::
        To correctly pass chars for printing as chars, they *must*
        be explicitly re-cast as such when calling the function.
]##
