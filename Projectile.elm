module Projectile exposing
  ( Projectile
  , bulletProjectile
  , grenadeProjectile
  , rocketProjectile
  , shotgunProjectile
  , smokeGrenadeProjectile
  , updateProjectiles
  , draw
  )

import Color
import Collage exposing (Form, collage, rect, filled, move, rotate, groupTransform)


type alias Projectile =
  { x : Float
  , y : Float
  , dx : Float
  , dy : Float
  , damages : Int
  , angle : Float
  , lifetime : Float
  }


newProjectile : (Float, Float) -> (Float, Float) -> Float -> Projectile
newProjectile (x, y) (dx, dy) angle =
  { x = x
  , y = y
  , dx = dx
  , dy = dy
  , damages = 0
  , angle = angle
  , lifetime = 3
  }


-- Balle de pistolet
-- @todo
bulletProjectile : (Float, Float) -> (Float, Float) -> Float -> Projectile
bulletProjectile (x, y) (dx, dy) angle =
  let
    projectile =
      newProjectile (x, y) (dx, dy) angle
  in
    { projectile
      | damages = 6
      , lifetime = 3
      }


-- Grenade
-- @todo
grenadeProjectile : (Float, Float) -> (Float, Float) -> Float -> Projectile
grenadeProjectile (x, y) (dx, dy) angle =
  let
    projectile =
      newProjectile (x, y) (dx, dy) angle
  in
    { projectile
      | lifetime = 4
      }


-- Roquette
-- @todo
rocketProjectile : (Float, Float) -> (Float, Float) -> Float -> Projectile
rocketProjectile (x, y) (dx, dy) angle =
  let
    projectile =
      newProjectile (x, y) (dx, dy) angle
  in
    { projectile
      | damages = 20
      , lifetime = 3
      }


-- Balle de fusil à pompe
-- @todo
shotgunProjectile : (Float, Float) -> (Float, Float) -> Float -> Projectile
shotgunProjectile (x, y) (dx, dy) angle =
  let
    projectile =
      newProjectile (x, y) (dx, dy) angle
  in
    { projectile
      | damages = 8
      , lifetime = 3
      }


-- Fumigène
-- @todo
smokeGrenadeProjectile : (Float, Float) -> (Float, Float) -> Float -> Projectile
smokeGrenadeProjectile (x, y) (dx, dy) angle =
  let
    projectile =
      newProjectile (x, y) (dx, dy) angle
  in
    { projectile
      | lifetime = 4
      }


-- Mettre à jour les projecties
updateProjectiles : Float -> List Projectile -> List Projectile
updateProjectiles dt projectiles =
  List.map (updateProjectile dt) projectiles |> removeDeadProjectiles


-- Supprimer les projectiles « morts »
removeDeadProjectiles : List Projectile -> List Projectile
removeDeadProjectiles projectiles =
  List.filter (\p -> p.lifetime > 0) projectiles


-- Mettre à jour un projectile
updateProjectile : Float -> Projectile -> Projectile
updateProjectile dt ({ x, y, dx, dy, lifetime } as projectile) =
  let
    lifetimeMinusDt =
      lifetime - dt

    newLifetime =
      if lifetimeMinusDt <= 0 then
        0
      else
        lifetimeMinusDt
  in
    { projectile
      | x = x + dx * dt
      , y = y + dy * dt
      , lifetime = newLifetime
      }


-- Afficher le joueur
draw : Projectile -> Form
draw { x, y, angle } =
  rect 10 2
    |> filled (Color.rgb 200 19 67)
    |> rotate (radians angle)
    |> move (x, y)
