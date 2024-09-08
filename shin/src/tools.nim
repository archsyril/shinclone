import std/tables
import std/strutils

proc tablelize*[T](data: openArray[T]): Table[string, ptr T] =
  for item in data:
    result[item.mark] = addr item

proc categorize*[T](data: Table[string, T], keys: varargs[string]): seq[T] =
  for key in keys:
    result.add(data[key])

proc mark*[T](item: T): T =
  var
    result = item
    name = replace(toLowerAscii(item.name), " ", "_")
  if len(name) <= 5:
    result.mark = name
  else:
    result.mark = name[0..2] & name[-1.. -2]

template entry*[T](varname: untyped, val: T): T =
  const `varname`* {.inject.} = val; `varname`