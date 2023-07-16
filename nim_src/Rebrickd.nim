##  Based on https://gbdev.io/gb-asm-tutorial/part2/getting-started.html
##  with a few extras thrown in

import gbdk/[
  video, io, input, interrupts, misc, print
]

proc `+=`(x: var uint16, y: int16) {.inline.} =
  ## here's an operator helper for adding int to uint
  if (y < 0):
    x = x - uint16(-y)
  else:
    x = x + uint16(y)

func asNumTiles(x: static int): uint8 =
  ## here's another helper to convert size to tiles
  const k = static:
    uint8(x / 0x10)
  k

# our graphics data
# incbin is relative to this file
const
  tilesBrick = incBin "../res/brick.2bpp"
  tilesLogo = incBin "../res/logo.2bpp"
  tilesPaddle = incBin "../res/paddle.2bpp"
  tilesBall = incBin "../res/ball.2bpp"
  tilesTitle = incBin "../res/title.2bpp"
  tilesNumerals = incBin "../res/numbers.2bpp"
  mapBrick = incBin "../res/game_area.tilemap"
  mapTitle = incBin "../res/title.tilemap"

# Some graphic-related enums
type
  FixedSpriteSlots = enum
    sPaddle
    sBall

  BgGfxParts = enum
    bgBorderTopLeft = 0'u8
    bgBorderTop
    bgBorderTopRight
    bgBlack
    bgBorderLeft
    bgPaddleLhalf
    bgPaddleRhalf
    bgBorderRight
    bgWhite
    bgBorderBottom

# Settings
const
  PaddleSpeed = 8
  PaddleMin = (8 * 3) shl 4
  PaddleMax = (8 * 12) shl 4
  BallStartX = (32 + 8) shl 4
  BallStartY = (100 + 16) shl 4
  MaxScore = 33 ## counted manually

# Game global state variables
var
  paddleX: uint16
  paddleXReal: uint8
  paddleYReal: uint8

  ballX: uint16    ## Precise X location
  ballXReal: uint8 ## OAM X location
  ballXColl: uint8 ## BG X loc, used for collision

  ballY: uint16    ## Precise Y location
  ballYReal: uint8 ## OAM Y location
  ballYColl: uint8 ## BG Y loc, used for collision

  ballSpeedX: int16
  ballSpeedY: int16
  paddleAcceleration: int16

  wyPos: uint16
  wyAcceleration: int16

  joyState: JoypadKeys

  paused: bool = false

# Now we want a custom type for score that's
# basically just a int with hooks
type
  Score = distinct int

var
  score: Score

  # we're not setting this to all zeros but
  # instead the tile for bgBlack
  scoreStr = block:
    var myArray: array[0..4, uint8]
    for x in myArray.mitems:
      x = bgBlack.uint8
    myArray

# And this is the hook we're gonna use
proc updateScore() {.inline.} =
  var temp = scoreStr.itoa(score.int, radix = 10)

  for i in 0..scoreStr.len:
    case temp[i]
    of char(0): # blank out terminator
      temp[i] = bgBlack.char
    of bgBlack.char:
      discard
    else:
      # shift characters to the correct order
      temp[i] = char(temp[i].uint8 - 0x10)

  setBkgTiles(
    16, 2, scoreStr.len.uint8, 1, cast[ptr uint8](temp)
  )

# and then when we change the score, the
# score counter changes with it:
proc `+=`(a: var Score, b: int) =
  a = Score(a.int + b)
  updateScore()

# but inherit this operator from the basetype..
proc `<=`(a: int, b: Score): bool {.borrow.}

# Game mode management

type GameMode = enum
  gmTitle = 0'u8
  gmGame
  gmIntermission

var gameMode: GameMode

# forward declaring some stuff here first

proc initTitle
proc initGame
proc runTitle
proc runGame
proc initIntermission
proc runIntermission

# game mode switch tables

# now I want to make these static in the
# generated C code, because these are
# somehow copied onto memory :(

const gameModeInits = [
  initTitle,
  initGame,
  initIntermission
]

const gameModeStep = [
  runTitle,
  runGame,
  runIntermission
]

proc `->`(gameMode: var GameMode, newGameMode: GameMode) =
  ## custom operator to change game modes just for the
  ## heck of it
  gameModeInits[newGameMode.ord]()
  gameMode = newGameMode

# Various funcs

func isCollidingTile(v: uint8): bool =
  # simple check against which tiles
  # that should collide with the ball
  BgGfxParts(v) in [
    bgBorderTopLeft,
    bgBorderTop,
    bgBorderTopRight,
    bgBorderRight,
    bgBlack,
    bgPaddleLhalf,
    bgPaddleRhalf
  ]

proc removeBrick(tile, x, y: uint8) =
  # when hitting one half of a brick,
  # remove the corresponding half as well
  case BgGfxParts(tile)
  of bgPaddleLhalf:
    setBkgTileXY(x, y, 8)
    setBkgTileXY(x+1, y, 8)
    score += 1
  of bgPaddleRhalf:
    setBkgTileXY(x, y, 8)
    setBkgTileXY(x-1, y, 8)
    score += 1
  else:
    discard

proc handlePaddle() {.inline.} =
  if jRight in joyState:
    paddleAcceleration += PaddleSpeed

  elif jLeft in joyState:
    paddleAcceleration -= PaddleSpeed

  # actually move paddle
  paddleX += paddleAcceleration

  # but clamp the movement
  if (paddleX >= PaddleMax):
    paddleX = PaddleMax
  elif (paddleX <= PaddleMin):
    paddleX = PaddleMin

  paddleXReal = uint8(paddleX shr 4)

  # decelerate paddle when we stop moving
  if (paddleAcceleration > 0):
    paddleAcceleration -= 4
  elif (paddleAcceleration < 0):
    paddleAcceleration += 4

proc handleBall() {.inline.} =
  ballXReal = uint8(ballX shr 4)
  ballXColl = (ballXReal-8) shr 3

  ballYReal = uint8(ballY shr 4)
  ballYColl = (ballYReal-16) shr 3

  # check tile collisions at ball's origin (top)
  if getBkgTileXY(ballXColl, ballYColl).isCollidingTile:
    ballSpeedY = -ballSpeedY
    getBkgTileXY(ballXColl, ballYColl).removeBrick(ballXColl, ballYColl)

  # ..at right..
  elif getBkgTileXY(ballXColl+1, ballYColl).isCollidingTile:
    ballSpeedX = -ballSpeedX
    getBkgTileXY(ballXColl+1, ballYColl).removeBrick(ballXColl+1, ballYColl)

  # ..at left..
  elif getBkgTileXY(ballXColl-1, ballYColl).isCollidingTile:
    ballSpeedX = -ballSpeedX
    getBkgTileXY(ballXColl-1, ballYColl).removeBrick(ballXColl-1, ballYColl)

  # check for collision with paddle
  if (ballYReal == paddleYReal-6) and
    (ballXReal >= paddleXReal-8) and
    (ballXReal <= paddleXReal+8):
    ballSpeedY = -ballSpeedY

  # accelerate ball
  ballX += ballSpeedX
  ballY += ballSpeedY

  if ballYReal > 0xa0 or ballXReal > 0x70 or # ball fell off
    score >= MaxScore: # beat the game
    gameMode -> gmIntermission

proc updateSprites() {.inline.} =
  moveSprite sPaddle.ord, paddleXReal, paddleYReal
  moveSprite sBall.ord, ballXReal, ballYReal

proc initTitle() =
  WyReg = 0
  wyPos = 0
  wyAcceleration = 0

  # cheaply hide sprites
  moveSprite sPaddle.ord, 0, 0
  moveSprite sBall.ord, 0, 0

  # fade in
  for i in [
    0b00000000,
    0b01000000,
    0b10010000,
    0b11100100
  ]:
    BgpReg = i.uint8
    delay 80

proc initGame() =
  # reload game area
  mapBrick.setBkgTiles(0, 0, 20, 18)

  score = 0.Score

  # reinit scoreStr
  for i in 0..scoreStr.len:
    scoreStr[i] = bgBlack.uint8

  # call manually just this once
  updateScore()

  # initialize our sprites
  tilesPaddle.setSpriteData(sPaddle.ord, tilesPaddle.len.asNumTiles)
  setSpriteTile sPaddle.ord, sPaddle.ord

  tilesBall.setSpriteData(sBall.ord, tilesBall.len.asNumTiles)
  setSpriteTile sBall.ord, sBall.ord

  # and the game variables
  paddleX = PaddleMin
  paddleXReal = (paddleX shr 4).uint8
  paddleYReal = 128+16

  ballX = BallStartX
  ballXReal = 0
  ballXColl = 0

  ballY = BallStartY
  ballYReal = 0
  ballYColl = 0

  ballSpeedX = 16
  ballSpeedY = -16
  paddleAcceleration = 0

proc initIntermission() =
  #[
    TODO: I can put a screen here showing
    the score and a prompt to press start
    before continuing, but I don't feel like
    it right now :(
  ]#
  # wait a while
  delay 800

  # fade out
  for i in [
    0b11100100,
    0b10010000,
    0b01000000,
    0
  ]:
    BgpReg = i.uint8
    Obp0Reg = BgpReg
    delay 60

  ballX = BallStartX
  ballY = BallStartY
  updateSprites()
  # reload game area
  mapBrick.setBkgTiles(0, 0, 20, 18)

  # fade back in
  for i in [
    0,
    0b01000000,
    0b10010000,
    0b11100100,
  ]:
    BgpReg = i.uint8
    Obp0Reg = BgpReg
    delay 60

proc runTitle() =
  ## press start to play!
  if jStart in joyState:
    gameMode -> gmGame

proc runGame() =
  if (WyReg < 0x90): # scroll the window down from title
    WyReg = uint8(wyPos shr 4)
    wyAcceleration += 4
    wyPos += wyAcceleration
    return

  updateSprites()
  handleBall()
  handlePaddle()

  if jStart in joyState:
    paused = not paused
    delay 300 # TODO: this is pretty sloppy

proc runIntermission() =
  ## there's nothing here, so
  ## let's just go back to the game
  gameMode -> gmGame

# entry point
when isMainModule:
  # first, reset colors
  BgpReg = 0b11100100
  Obp0Reg = BgpReg
  Obp1Reg = Obp0Reg

  # prepare UI stuff
  fillBkgRect(0, 0x12, 0x20, 12, bgWhite.ord)
  tilesBrick.setBkgData(0, tilesBrick.len.asNumTiles)
  tilesLogo.setBkgData(10, tilesLogo.len.asNumTiles)
  tilesNumerals.setBkgData(0x20, tilesNumerals.len.asNumTiles)

  tilesTitle.setWinData(0x80, tilesTitle.len.asNumTiles)
  mapTitle.setWinTiles(0, 0, 20, 18)

  LcdcReg = {
    lcdcOn, lcdcBgOn, lcdcWinOn, lcdcObjOn, lcdcWin9c00
  }

  gameMode -> gmTitle

  while true:
    # we're gonna be reading
    # inputs either way so might
    # as well do it here
    joyState = joypad()

    if not paused:
      # run the game loop
      gameModeStep[gameMode.ord]()
    else:
      # run the pause loop instead
      if jStart in joyState:
        paused = false
        delay 300 # TODO: this is pretty sloppy
    
    # finish frame
    waitVblDone()
