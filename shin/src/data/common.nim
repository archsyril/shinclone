import std/strutils
import std/hashes

type Direction* = enum
  NW, N, NE,
   W,     E,
  SW, S, SE,

type StrPointer* = Hash
converter strptrToHash*(str: string): Hash = hash(str)

type Percent* = range[0'u8..100'u8]

type RGB* = tuple[r,g,b: uint8]

type Seasons* = enum
  Spring, Summer, Fall, Winter

const regFarmTime* = @[Spring, Summer, Fall]
