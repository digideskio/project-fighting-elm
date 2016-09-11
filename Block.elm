module Block exposing (..)

import Utils exposing (Point)


type BlockType
  = CrateBlock
  | DynamiteBlock
  | MineBlock


type alias Block =
  { pos : Point
  }


crateBlock : Block
crateBlock =
  { pos = { x = 0, y = 0}
  }


dynamiteBlock : Block
dynamiteBlock =
  { pos = { x = 0, y = 0}
  }


mineBlock : Block
mineBlock =
  { pos = { x = 0, y = 0}
  }
