import player, animal, building, terrain

type Tile* = object
  terrain*: Terrain
  growth*: uint8
  feature*: Feature
  buildings*: seq[RealBuilding]
  players*: seq[Player]
  animals*: seq[RealAnimal]
