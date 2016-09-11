module Particle exposing (..)


type alias Particle =
  { x : Float
  , y : Float
  , dx : Float
  , dy : Float
  }


particle : Particle
particle =
  { x = 0
  , y = 0
  , dx = 0
  , dy = 0
  }
