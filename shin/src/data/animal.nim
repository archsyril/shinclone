import ../tools
import common, loot

type Animal* = object
  mark*, name*: string
  max_hp*: uint8
  dmg*: uint8
  fight, flee*: Percent
  hunts*: bool
  oceanic*: bool
  carcass*: seq[Loot] # Animals drop their carcass upon death, it must be butchered.

type RealAnimal* = object
  data*: ptr Animal
  hp*: int16
  x*,y*,z*: int16
  hunger*: int8

# Crocodile, Goose, Duck, Pheasant, Mountain lion, Boar

const data = [
  Animal(name: "Beehive",
    max_hp: 10, dmg: 2, fight: 80,
    carcass: @[("honey_comb", 3)]),

  Animal(name: "Squirrel",
    max_hp: 6, dmg: 1, fight: 10, flee: 90,
    carcass: @[("raw_meat", 1), ("small_pelt", 1)]),

  Animal(name: "Rat",
    max_hp: 7, dmg: 3, fight: 40, flee: 40,
    carcass: @[("bone", 1)]),

  Animal(name: "Rabbit",
    max_hp: 8, dmg: 2, fight: 20, flee: 80,
    carcass: @[("raw_meat", 2), ("bone", 1), ("small_pelt", 1)]),

  Animal(name: "Sheep",
    max_hp: 16, dmg: 5, fight: 50, flee: 50,
    carcass: @[("raw_meat", 5), ("wool", 5), ("bone", 4), ("pelt", 1)]),

  Animal(name: "Sheared Sheep",
    max_hp: 16, dmg: 5, fight: 60, flee: 60,
    carcass: @[("raw_meat", 5), ("bone", 4), ("pelt", 1)]),

  Animal(name: "Deer",
    max_hp: 14, dmg: 6, fight: 30, flee: 70,
    carcass: @[("raw_meat", 9), ("bone", 8), ("pelt", 1)]),

  Animal(name: "Moose",
    max_hp: 24, dmg: 10, fight: 50, flee: 50,
    carcass: @[("raw_meat", 9), ("bone", 8), ("pelt", 1)]),

  Animal(name: "Buffalo",
    max_hp: 30, dmg: 12, fight: 60, flee: 50,
    carcass: @[("raw_meat", 12), ("bone", 10), ("large_pelt", 1)]),

  Animal(name: "Wolf",
    max_hp: 20, dmg: 10, fight: 80, flee: 40, hunts: true,
    carcass: @[("raw_meat", 4), ("bone", 4), ("pelt", 1)]),

  Animal(name: "Bear",
    max_hp: 40, dmg: 16, fight: 70, flee: 30, hunts: true,
    carcass: @[("raw_meat", 10), ("bone", 6), ("large_pelt", 1)]),

  Animal(name: "Fish",
    max_hp: 2, flee: 90,
    oceanic: true,
    carcass: @[("raw_fish", 3)]),

  Animal(name: "Shark" ,
    max_hp: 70, dmg: 20, fight: 90, flee: 20, hunts: true,
    oceanic: true,
    carcass: @[("raw_fish", 10), ("shark_tooth", 1)]),
]

let animals* = tablelize(data)