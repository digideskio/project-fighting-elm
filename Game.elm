module Game exposing (..)

import Mouse
import Utils
import Projectile exposing (Projectile)
import Block exposing (Block)
import Player exposing (Player, newPlayer)
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
  , currentPlayerId : Int
  , uid : Int
  }


fire : Game -> Mouse.Position -> Weapon -> Game
fire game direction weapon =
  let
    player = getCurrentPlayer game
    dirX = toFloat direction.x
    dirY = toFloat direction.y
    angle = Utils.angleBetween (dirX, dirY) (player.x, player.y)
    dx = cos(angle) * 120
    dy = sin(angle) * 120
  in
    case weapon.weaponType of
      Dynamite ->
        game
        -- { game | blocks = dynamiteBlock :: game.blocks }

      FlameThrower ->
        game

      Grenade ->
        { game | projectiles = grenadeProjectile dx dy angle :: game.projectiles }

      Gun ->
        { game | projectiles = bulletProjectile dx dy angle :: game.projectiles }

      Mine ->
        game
        -- { game | blocks = mineBlock :: game.blocks }

      RocketLauncher ->
        { game | projectiles = rocketProjectile dx dy angle :: game.projectiles }

      Shotgun ->
        { game | projectiles = shotgunProjectile dx dy angle :: game.projectiles }

      SmokeGrenade ->
        { game | projectiles = smokeGrenadeProjectile dx dy angle :: game.projectiles }

      SubmachineGun ->
        game


getPlayer : Game -> Int -> Player
getPlayer game id =
  let
    player = List.filter (\p -> p.id == id) game.players |> List.head
  in
    case player of
      Just p ->
        p

      Nothing ->
        newPlayer game.uid


getCurrentPlayer : Game -> Player
getCurrentPlayer game =
  let
    player = List.filter (\p -> p.id == game.currentPlayerId) game.players |> List.head
  in
    case player of
      Just p ->
        p

      Nothing ->
        newPlayer game.uid
