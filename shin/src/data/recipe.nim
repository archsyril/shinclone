import item, furniture, building

type ItemName* = string

type RecipeItem* = tuple[item: Item, amnt: uint8, exhaust: bool]

type Recipe* = object
  mat*: seq[RecipeItem]
  tools*: seq[Item]
  req*: ptr Furniture
  # but we can craft buildings, items, furniture
  result*: tuple[item: Item, amnt: uint8]

template use*(name: ItemName, amnt: uint8 = 0): RecipeItem = (items[name], amnt, true)
template ret*(name: ItemName, amnt: uint8 = 0): RecipeItem = (items[name], amnt, false)