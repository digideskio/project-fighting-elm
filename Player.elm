module Player exposing (..)

import Weapon
import Weapon exposing (Weapon, newGun)

import Color
import Collage exposing (Form, collage, rect, filled, move)


type alias Player =
  { x : Float
  , y : Float
  , dx : Float
  , dy : Float
  , id : Int
  , weapon : Weapon
  }


newPlayer : Int -> Player
newPlayer id =
  { x = 0
  , y = 0
  , dx = 0
  , dy = 0
  , id = id
  , weapon = newGun
  }


-- Mettre à jour les joueurs
updatePlayers : Float -> List Player -> List Player
updatePlayers dt projectiles =
  List.map (updatePlayer dt) projectiles


-- Mettre à jour un joueur
updatePlayer : Float -> Player -> Player
updatePlayer dt ({ x, y, dx, dy, weapon } as player) =
  { player
    | x = x + dx * dt
    , y = y + dy * dt
    , weapon = Weapon.updateWeapon dt weapon
    }


resetPlayerWeapon : Player -> Player
resetPlayerWeapon ({ weapon } as player) =
  { player
    | weapon = Weapon.resetWeaponLatency weapon
    }


-- Afficher le joueur
draw : Player -> Form
draw { x, y } =
  rect 50 50
    |> filled (Color.rgb 30 19 67)
    |> move (x, y)
