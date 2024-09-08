import std/tables

import ../tools
import common, furniture

type ItemPurpose* = enum
  None, Weapon, Food, Heal, Furniture

type Item* = object
  mark*, name*: string
  desc*: string
  weight*: float
  case use*: ItemPurpose
  of Weapon: # Weapons are stored in their own database
    accuracy: Percent
    attack: uint8
    durability: uint8
  of Food:
    feeds: uint8
  of Heal:
    heals: uint8
  of Furniture:
    makes: StrPointer
  else: discard

const data = [
  mark Item(name: "Stick", weight: 0.5,
    use: Weapon, accuracy: 25.Percent, attack: 1, durability: 10),
  mark Item(name: "Rock", weight: 2,
    use: Weapon, accuracy: 15.Percent, attack: 2, durability: 20),
  mark Item(name: "Large Rock", weight: 6),
  mark Item(name: "Flint", weight: 1),

  mark Item(name: "Reed", weight: 0.2),
  mark Item(name: "Dry Grass", weight: 0.2),
  mark Item(name: "Thyme Sprig", weight: 0.2,
    use: Heal, heals: 5),
  mark Item(name: "Bark", weight: 0.2),
  mark Item(name: "Poultrice", weight: 0.5,
    use: Heal, heals: 40),
  mark Item(name: "Wheat", weight: 0.2),
  mark Item(name: "Honeycomb", weight: 0.5,
    use: Heal, heals: 10),

  mark Item(name: "Chestnut", weight: 0.1,
    use: Food, feeds: 4),
  mark Item(name: "Onion", weight: 0.2,
    use: Food, feeds: 8),
  mark Item(name: "Bread", weight: 1,
    use: Food, feeds: 25),

  mark Item(name: "Bone", weight: 0.8),
  mark Item(name: "Horn", weight: 3),
  mark Item(name: "Small Pelt", weight: 2),
  mark Item(name: "Pelt", weight: 4),
  mark Item(name: "Large Pelt", weight: 9),

  mark Item(name: "Raw Meat", weight: 0.5),
  mark Item(name: "Cooked Meat", weight: 0.5,
    use: Food, feeds: 30),

  mark Item(name: "Log", weight: 12),
  mark Item(name: "Timber", weight: 3),
  mark Item(name: "Stone Block", weight: 4),
  mark Item(name: "Clay", weight: 2),
  mark Item(name: "Sand", weight: 1.6),

  mark Item(name: "Clay Pot", weight: 2,
    use: Furniture, makes: "pot"),
  mark Item(name: "Pot of Water", weight: 8),
  mark Item(name: "Pot of Flour", weight: 4),


  mark Item(name: "Grinding Stone", weight: 4,
    use: Furniture, makes: "stonemason"),

]

let items* = tablelize(data)
  