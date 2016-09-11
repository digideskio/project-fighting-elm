module Player exposing (..)


type alias Player =
  { x : Float
  , y : Float
  , dx : Float
  , dy : Float
  , id : Int
  }


newPlayer : Int -> Player
newPlayer id =
  { x = 0
  , y = 0
  , dx = 0
  , dy = 0
  , id = id
  }


-- Mettre à jour les joueurs
updatePlayers : Float -> List Player -> List Player
updatePlayers dt projectiles =
  List.map (updatePlayer dt) projectiles


-- Mettre à jour un joueur
updatePlayer : Float -> Player -> Player
updatePlayer dt ({ x, y, dx, dy } as player) =
  { player
    | x = x + dx * dt
    , y = y + dy * dt
    }
