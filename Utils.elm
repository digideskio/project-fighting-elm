module Utils exposing (..)


angleBetween : (Float, Float) -> (Float, Float) -> Float
angleBetween (x1, y1) (x2, y2) =
  atan2 (y1 - y2) (x1 - x2)
