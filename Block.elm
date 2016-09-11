module Block exposing (..)


type BlockType
  = CrateBlock
  | DynamiteBlock
  | MineBlock


type alias Block =
  { x : Float
  , y : Float
  }


crateBlock : Block
crateBlock =
  { x = 0
  , y = 0
  }


dynamiteBlock : Block
dynamiteBlock =
  { x = 0
  , y = 0
  }


mineBlock : Block
mineBlock =
  { x = 0
  , y = 0
  }
