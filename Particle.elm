module Particle exposing (..)

import Utils exposing (Point)


type alias Particle =
  { pos : Point
  , vel : Point
  }


particle : Particle
particle =
  { pos = { x = 0, y = 0 }
  , vel = { x = 0, y = 0 }
  }
