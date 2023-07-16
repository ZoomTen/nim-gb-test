##
## GBDK bindings docs
## ------------------
##
## .. warning::
##    These bindings are very much incomplete, and
##    only implements a subset of GBDK.
## 
## For now, this is just copied verbatim from the
## GBDK manual.
## 
## What do you wanna do?
## 
## - `input <input.html>`_ ⸺ handle joypad input
## - `interrupts <interrupts.html>`_ ⸺ manage interrupts
## - `drawing <drawing.html>`_ ⸺ draw shapes in spite of the hardware design
## - `video <video.html>`_ ⸺ manage VRAM
## - `metasprites <metasprites.html>`_ ⸺ Use GBDK's metasprite structs
## - `serial <serial.html>`_ ⸺ send and receive data
## - `misc <misc.html>`_ ⸺ wait, reset the game, ...
## - `copy <copy.html>`_ ⸺ copy data from one place to another
## - `print <print.html>`_ ⸺ print something to the screen
## - `io <io.html>`_ ⸺ manipulate raw memory

import std/compilesettings

when querySetting(command) in ["doc", "jsondoc", "doc2tex"]:
  import input
  import interrupts
  import drawing
  import video
  import metasprites
  import serial
  import misc
  import copy
  import print
  import io

else:
  {.error: "This module is for doc gen only.".}
