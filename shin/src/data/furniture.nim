import std/tables
import ../tools

type Furniture* = object
  mark*, name*: string
  space*: uint8
  stores*: int16 # used if a furniture can be used for limited storage
  outside*: bool # Can be built outside
  common*: bool # Can exist more than one in a building

const TotalSpace* = 100

const data = [
  mark Furniture(name: "Workshop", space: 60),
  mark Furniture(name: "Hospital", space: 50),
  mark Furniture(name: "Stonemason", space: 70),
  mark Furniture(name: "Bakery", space: 60),
  mark Furniture(name: "Kiln", space: 60),
  mark Furniture(name: "Sawmill", space: 70),
  mark Furniture(name: "Quorn", space: 20),
  mark Furniture(name: "Windmill", space: 20),
  mark Furniture(name: "Campfire", space: 10, outside: true),
  mark Furniture(name: "Loom", space: 40),
  mark Furniture(name: "Pot", space: 05, stores: 20, common: true),
  mark Furniture(name: "Bin", space: 10, stores: 70, common: true),
]

let furniture* = tablelize(data)