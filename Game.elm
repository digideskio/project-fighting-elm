module Game exposing (..)

import Mouse
import Utils
import Projectile exposing (Projectile)
import Block exposing (Block, dynamiteBlock, mineBlock)
import Player exposing (Player, newPlayer, resetPlayerWeapon)
import Particle exposing (Particle)
import Weapon exposing (Weapon, WeaponType(..))
import Projectile exposing
  ( bulletProjectile
  , grenadeProjectile
  , rocketProjectile
  , shotgunProjectile
  , smokeGrenadeProjectile
  )


type alias Map = List (List Int)


type alias Game =
  { width : Int
  , height : Int
  , map : Map
  , projectiles : List Projectile
  , blocks : List Block
  , players : List Player
  , particles : List Particle
  , firing : Bool
  , mousePos : { x : Int, y : Int }
  , currentPlayerId : Int
  , uid : Int
  }


fire : Game -> Mouse.Position -> Weapon -> Game
fire game direction weapon =
  let
    canFire =
      if weapon.latency <= 0 then
        True
      else
        False

    player =
      getCurrentPlayer game

    dirX =
      toFloat direction.x

    dirY =
      toFloat direction.y

    angle =
      Utils.angleBetween (dirX - (toFloat game.width / 2), -(dirY - (toFloat game.height / 2))) (player.x, player.y)

    dx =
      cos(angle) * 120

    dy =
      sin(angle) * 120

    pos =
      (player.x, player.y)

    dir =
      (dx, dy)

    newGame =
      if canFire then
        { game | players = [ resetPlayerWeapon player ] }
      else
        game
  in
    if canFire then
      case weapon.weaponType of
        Dynamite ->
          { game | blocks = dynamiteBlock :: game.blocks }

        FlameThrower ->
          game

        Grenade ->
          { game | projectiles = grenadeProjectile pos dir angle :: game.projectiles }

        Gun ->
          { game | projectiles = bulletProjectile pos dir angle :: game.projectiles }

        Mine ->
          { game | blocks = mineBlock :: game.blocks }

        RocketLauncher ->
          { game | projectiles = rocketProjectile pos dir angle :: game.projectiles }

        Shotgun ->
          { game | projectiles = shotgunProjectile pos dir angle :: game.projectiles }

        SmokeGrenade ->
          { game | projectiles = smokeGrenadeProjectile pos dir angle :: game.projectiles }

        SubmachineGun ->
          game
    else
      game


getPlayer : Game -> Int -> Player
getPlayer game id =
  let
    player =
      List.filter (\p -> p.id == id) game.players |> List.head
  in
    case player of
      Just p ->
        p

      Nothing ->
        newPlayer game.uid


getCurrentPlayer : Game -> Player
getCurrentPlayer game =
  let
    player =
      List.filter (\p -> p.id == game.currentPlayerId) game.players |> List.head
  in
    case player of
      Just p ->
        p

      Nothing ->
        newPlayer game.uid
