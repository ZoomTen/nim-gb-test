{.pragma: gb, header: "<gb/gb.h>".}
{.warning[UnusedImport]: off.}
{.hint[XDeclaredButNotUsed]: off.}

##[
Everything to do with handling input goes here.

Joypad polling example:

.. code-block:: nim
    import gbdk/input
    
    while true:
      # First, get the current state
      var joyState = joypad()
      
      # check one button
      if (jRight in joyState):
        printf "right pressed!\n"
      
      # check one or two buttons
      elif (jUp in joyState or jDown in joyState):
        printf "up or down pressed!\n"
      
      # check button combination
      elif (joyState == {jLeft, jB}):
        printf "left+B pressed!\n"

Setting up for SGB multi-joypad example:

.. code-block:: nim
    import gbdk/input
    
    # setup the joypad reader
    var joyPads = Joypads()
    
    # init 1 joypad
    discard joyPads.joypadInit(1)
    
    while true:
      # update the joypad state
      joyPads.joypadEx()
      
      # read from it...
      if jUp in joyPads.joy0:
        printf "J0: up pressed!"
]##

type
  JoypadKey* {.size: 1.} = enum
    jRight
    jLeft
    jUp
    jDown
    jA
    jB
    jSelect
    jStart

  JoypadKeys* = set[JoypadKey] ##[
    Indicates which keys are currently pressed.
    
    See also
      - `joypad`_
      - `joypadEx template`_
  ]##

proc joypad*(): JoypadKeys {.importc, gb.} ##[
    Reads and returns the current state of the joypad.
    Follows Nintendo's guidelines for reading the pad.

    When testing for multiple different buttons, it's
    best to read the joypad state *once* into a variable
    and then test using that variable.
]##

proc waitpad*(mask: set[JoypadKey]): uint8 {.importc, gb.} ##[
    Waits until at least one of the buttons given in mask are pressed.

    Normally only used for checking one key, but it will
    support many, even ``jLeft`` at the same time as ``jRight``. :)

    Note: Checks in a loop that doesn't HALT at all, so the CPU
    will be maxed out until this call returns.
    
    See also: `joypad`_
]##

proc waitpadUp*() {.importc, gb.} ##[
    Waits for the directional pad and all buttons to be released.

    Note: Checks in a loop that doesn't HALT at all, so the CPU
    will be maxed out until this call returns.
]##

type
  Joypads* {.importc: "joypads_t", gb.} = object ##[
    Multiplayer joypad structure.

    Must be initialized with `joypadInit`_ first then it
    may be used to poll all avaliable joypads with `joypadEx`_
]##
    npads*, joy0*, joy1*, joy2*, joy3*: JoypadKeys

proc joypadInit*(npads: uint8, joypads: ptr Joypads): uint8 {.importc: "joypad_init", gb.}

template joypadInit*(joypads: Joypads, npads: uint8): uint8 = ##[
    Initializes joypads_t structure for polling multiple joypads
    (for the GB and ones connected via SGB)

    Params:
        - `joypads` pointer to joypads_t structure to be initialized
        - `npads` number of joypads requested (1, 2 or 4)
    
    Only required for `joypadEx`_, not required for calls to regular `joypad`_

    Returns:
      - number of joypads available
    
    See also:
      - `joypadEx`_
      - `Joypads`_
]##
  joypadInit(npads, unsafeAddr joypads)

proc joypadEx*(joypads: ptr Joypads) {.importc: "joypad_ex", gb.}
template joypadEx*(joypads: Joypads) = ##[
    Polls all avaliable joypads (for the GB and ones connected via SGB)

    Params:
      - `joypads` Must be previously initialized with `joypadInit`_
    
    See also:
      - `joypadInit`_
      - `Joypads`_
]##
  joypadEx(unsafeAddr joypads)

