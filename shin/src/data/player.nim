import std/[times]
import common

type Player* = object
  name*: string
  hp*, max_hp*: int16
  ap*, max_ap*: int16
  xp*: int16
  x*,y*,z*: int16
  hunger*: int8
  #items*: seq[Item]
  #weight*: int16
  last_action*: DateTime

proc move*(self: var Player, dir: Direction) =
  case dir: 
  of NW: self.y -= 1; self.x -= 1
  of N:  self.y -= 1
  of NE: self.y -= 1; self.x += 1
  of  W:              self.x -= 1
  of  E:              self.x += 1
  of SW: self.y += 1; self.x -= 1
  of S:  self.y += 1
  of SE: self.y += 1; self.x += 1