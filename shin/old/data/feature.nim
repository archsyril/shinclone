import common
import std/tables

type FeatureObj = object
  name*, pname*: string
  writable*: bool
  descend*, ascend*: bool
type Feature* = ref FeatureObj

const data = [
  FeatureObj(name: "cave_entrance", writable: true, descend: true),
  FeatureObj(name: "cave_exit", writable: true, ascend: true),
  FeatureObj(name: "pit", descend: true),
  FeatureObj(name: "boulder", writable: true), 
  FeatureObj(name: ""),
]

let features* = makeTable[Feature](data)


converter toFeature*(dbs: DbString): Feature =
  features[dbs]