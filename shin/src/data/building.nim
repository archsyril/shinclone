import ../tools
import std/tables

type Building* = object
  mark*, name*: string
  enterable*: bool
  writable*: bool
  storable*: bool
  impassable*: bool
  unnamable*: bool
  max_hp*: int16
  space*: uint8

type RealBuilding* = object
  given_name*: string # 20 chars, for a flavor name
  data*: ptr Building
  settlementID*: int
  #build_date*: DateTime
  hp*: int
  stockpileID*: int
  #items*: seq[Items]

# TODO: when a building is built, it is started at 5-10% of it's total hp and must be finished

const data = [
  mark Building(name: "Farmland", max_hp: 100), # Watered to be turned into irrigated
  mark Building(name: "Irrigated Farmland", max_hp: 100), # has been watered (temporary), near 

  mark Building(name: "Stockpile", writable: true, storable: true, max_hp: 50),
  mark Building(name: "Reinforced Stockpile", writable: true, storable: true, max_hp: 200),

  mark Building(name: "Statue", writable: true, max_hp: 300),
  mark Building(name: "Monument", writable: true, max_hp: 600),
  
  mark Building(name: "Well", max_hp: 200, unnamable: true),

  mark Building(name: "Market Stall", storable: true, max_hp: 120),

  mark Building(name: "Hut", enterable: true, writable: true, max_hp: 50, space: 20),
  mark Building(name: "Shack", enterable: true, writable: true, max_hp: 120, space: 40),
  mark Building(name: "Longhouse", enterable: true, writable: true, max_hp: 260, space: 70),
  mark Building(name: "Stone Home", enterable: true, writable: true, max_hp: 400, space: 100),
  mark Building(name: "Keep", enterable: true, writable: true, max_hp: 900, space: 120),

  mark Building(name: "Dirt Trail", max_hp: 40, unnamable: true),
  mark Building(name: "Gravel Path", max_hp: 260, unnamable: true),
  mark Building(name: "Stone Road", max_hp: 650, unnamable: true),

  mark Building(name: "Palisade Wall", max_hp: 160, impassable: true, unnamable: true),
  mark Building(name: "Palisade Gatehouse", max_hp: 160),
  mark Building(name: "Wooden Tower", max_hp: 140, unnamable: true),
  mark Building(name: "Wooden Bridge", max_hp: 110, unnamable: true),

  mark Building(name: "Stone Wall", max_hp: 400, impassable: true, unnamable: true),
  mark Building(name: "Stone Gatehouse", max_hp: 400),
  mark Building(name: "Stone Tower", max_hp: 370, unnamable: true),
  mark Building(name: "Stone Bridge", max_hp: 350, unnamable: true),
]

let
  buildings* = tablelize(data)

  bridges* = buildings.categorize("wooden_bridge", "stone_bridge")
  smallBuildings* = buildings.categorize("stockpile", "statue", "monument", "well", "market_stall", "hut", "shack", "longhouse", "dirt_trail", "gravel_path", "palisade_wall", "palisade_gatehouse", "wooden_tower")