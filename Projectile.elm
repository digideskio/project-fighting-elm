module Projectile exposing (..)


type alias Projectile =
  { x : Float
  , y : Float
  , dx : Float
  , dy : Float
  , damages : Int
  , angle : Float
  , lifetime : Float
  }


newProjectile : Projectile
newProjectile =
  { x = 0
  , y = 0
  , dx = 1
  , dy = 1
  , damages = 20
  , angle = 0
  , lifetime = 3
  }


-- Balle de pistolet
-- @todo
bulletProjectile : Projectile
bulletProjectile = newProjectile


-- Grenade
-- @todo
grenadeProjectile : Projectile
grenadeProjectile = newProjectile


-- Roquette
-- @todo
rocketProjectile : Projectile
rocketProjectile = newProjectile


-- Balle de fusil à pompe
-- @todo
shotgunProjectile : Projectile
shotgunProjectile = newProjectile


-- Fumigène
-- @todo
smokeGrenadeProjectile : Projectile
smokeGrenadeProjectile = newProjectile


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
    lifetimeMinusDt = lifetime - dt

    newLifetime = if lifetimeMinusDt <= 0 then
      0
    else
      lifetimeMinusDt
  in
    { projectile
      | x = x + dx * dt
      , y = y + dy * dt
      , lifetime = newLifetime
      }
