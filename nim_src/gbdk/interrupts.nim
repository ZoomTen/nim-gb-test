{.pragma: gb, header: "<gb/gb.h>".}
{.warning[UnusedImport]: off.}
{.hint[XDeclaredButNotUsed]: off.}

import macros

# by @terry https://forum.nim-lang.org/t/1804
proc newEmitPragma(s: string): NimNode {.compileTime.} =
  result = nnkPragma.newTree()
  result.add(newColonExpr(newIdentNode("emit"), newStrLitNode(s)))

##[
  Interrupt-related functions. Add handlers, remove handlers,
  wait for interrupts ...
]##

type
  InterruptFlag* = enum
    intVBlank = 1
    intLcd = 2
    intTimer = 3
    intSerial = 4
    intJoypad = 5,

  InterruptFlags* = set[InterruptFlag] ##[
    See also:
      - `setInterrupts`_.
  ]##

proc waitVblDone*() {.importc: "wait_vbl_done", gb.} ##[
    HALTs the CPU and waits for the vertical blank interrupt (VBL) to finish.

    This is often used in main loops to idle the CPU at low power
    until it's time to start the next frame. It's also useful for
    syncing animation with the screen re-draw.

    .. warning::
        If the VBL interrupt is disabled, this function will
        never return. If the screen is off this function returns
        immediately.
]##

macro critical*(f: untyped): untyped = ##[
  Mark a block of code as "critical" in SDCC's terms (that is, disable
  interrupts before this block and re-enable it afterwards)
  
  See also `the relevant SDCC man section
  <https://sdcc.sourceforge.net/doc/sdccman.pdf#section.3.9>`_.
  
  This macro should be invoked inside of a proc, otherwise
  the emit will be placed at the wrong place.
]##
  result = newNimNode(nnkStmtList)
  result.add(newEmitPragma "CRITICAL {")
  result.add(f)
  result.add(newEmitPragma "}")

proc addLcdHandlerC(handler: pointer) {.importc: "add_LCD", gb.}
template addLcdHandler*(handler: proc(): void) = ##[
    Adds a LCD interrupt handler.

    Called when the LCD interrupt occurs, which is normally
    when `LyReg`_ == `LycReg`_.

    Up to 3 handlers may be added, with the last added
    being called last.

    There are various reasons for this interrupt to occur
    as described by the `StatReg`_ register ($FF41). One very
    popular reason is to indicate to the user when the
    video hardware is about to redraw a given LCD line.
    This can be useful for dynamically controlling the
    `ScxReg`_ / `ScyReg`_ registers ($FF43/$FF42) to perform
    special video effects.
    
    *Do not* use `critical`_ and `interrupt` when declaring
    ISR functions added via `addVbl`_ (or LCD, etc).
    Those attributes are only required when constructing
    a bare jump from the interrupt vector itself (such as
    with `isrVector`_.

    ISR handlers added using `addVbl`_ are instead
    called via the GBDK ISR dispatcher which makes
    the extra function attributes unecessary.

    If this ISR is to be called once per each scanline then
    make sure that the time it takes to execute is less
    than the duration of a scanline.

    See also:
      - `addVbl`_
      - `nowaitIntHandler`_
      - `isrVector`_
]##
  addLcdHandlerC(handler)

proc setInterrupts*(ints: InterruptFlags) {.importc: "set_interrupts", gb.} ##[
    Clears any pending interrupts and sets the interrupt mask
    register IO to flags.

    Params:
      - `flags`
      
    .. note::
      This disables and then re-enables interrupts so it
      must be used outside of a critical section.

    See also:
      - `enableInterrupts`_
      - `disableInterrupts`_
      - `InterruptFlags`_
]##
