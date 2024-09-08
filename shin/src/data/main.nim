import std/tables
import player
import furniture
import common
var pl = Player(x: 1, y: 1, z: 1)
move(pl, E)
echo furnitures["bin"][]