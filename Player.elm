module Player exposing (..)

import Utils exposing (Point)


type alias Player =
  { pos : Point
  , vel : Point
  }


player : Player
player =
  { pos = { x = 0, y = 0 }
  , vel = { x = 0, y = 0 }
  }
