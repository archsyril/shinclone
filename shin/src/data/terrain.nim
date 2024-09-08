import ../tools
import loot

type BuildType* = enum
  None, Bridge, Small, Large

type GrowthType* = enum
  None, Grass, Trees, Reeds, Mushrooms

type Terrain* = object
  mark*, name*: string
  ap*: float32
  buildable*: BuildType
  farm_rate*: float32
  grows*: GrowthType # what grows here (if anything)

const totalGrowth* = 8 # How much growth can occur on a tile
const replenishment* = 10 # How many items may be found on one tile in a day

type RealTerrain* = object
  data*: ptr Terrain
  growth*: range[0..totalGrowth]
  

const data = [
  mark Terrain(name: "Grassland", ap: 0.5, buildable: Large, farm_rate: 1.2, grows: Grass),
  mark Terrain(name: "Tundra", ap: 0.75, buildable: Large, farm_rate: 0.4, grows: Grass),
  mark Terrain(name: "Floodplain", ap: 0.75, buildable: Large, farm_rate: 1.4, grows: Grass),
  mark Terrain(name: "Marsh", ap: 1.5, buildable: Small, farm_rate: 0.9, grows: Reeds),
  mark Terrain(name: "Sparse Swamp", ap: 2, buildable: Small, farm_rate: 0.7, grows: Trees),
  mark Terrain(name: "Sparse Taiga", ap: 1, buildable: Small, farm_rate: 0.7, grows: Trees),
  mark Terrain(name: "Sparse Forest", ap: 1, buildable: Small, farm_rate: 0.8, grows: Trees),
  mark Terrain(name: "Swamp", ap: 3, buildable: Small, grows: Trees),
  mark Terrain(name: "Taiga", ap: 2, buildable: Small, grows: Trees),
  mark Terrain(name: "Forest", ap: 2, buildable: Small, grows: Trees),
  mark Terrain(name: "Thick Swamp", ap: 5, buildable: Small, grows: Trees),
  mark Terrain(name: "Thick Forest", ap: 4, buildable: Small, grows: Trees),
  mark Terrain(name: "Thick Taiga", ap: 4, buildable: Small, grows: Trees),
  mark Terrain(name: "Rockland", ap: 1, buildable: Large),
  mark Terrain(name: "Beach", ap: 1.2, buildable: Small),
  
  mark Terrain(name: "Frozen Plains", ap: 2, buildable: Large),
  mark Terrain(name: "Glacier", ap: 3, buildable: Small),

  mark Terrain(name: "Cave", ap: 1, buildable: Small),
  mark Terrain(name: "Damp Cave", ap: 1.2, buildable: Small, grows: Mushrooms),

  mark Terrain(name: "Bog", ap: 12, buildable: Bridge),
  mark Terrain(name: "Pond", ap: 4, buildable: Bridge, grows: Reeds),
  mark Terrain(name: "River", ap: 12, buildable: Bridge),
  mark Terrain(name: "Lake", ap: 8, buildable: Bridge),
  mark Terrain(name: "Coast", ap: 8, buildable: Bridge),
  mark Terrain(name: "Ocean", ap: 10),

  mark Terrain(name: "Mountain", ap: 90),
  mark Terrain(name: "Void"),
]

let terrain* = tablelize(data)

let wetTerrain* = terrain.categorize("bog", "pond", "river", "lake", "coast", "ocean")