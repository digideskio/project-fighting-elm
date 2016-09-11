module Player exposing (..)


type alias Player =
  { x : Float
  , y : Float
  , dx : Float
  , dy : Float
  }


player : Player
player =
  { x = 0
  , y = 0
  , dx = 0
  , dy = 0
  }
