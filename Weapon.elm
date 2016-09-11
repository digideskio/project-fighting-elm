module Weapon exposing (..)


type WeaponType
  = Dynamite
  | FlameThrower
  | Grenade
  | Gun
  | Mine
  | RocketLauncher
  | Shotgun
  | SmokeGrenade
  | SubmachineGun


type alias Weapon =
  { name : String
  , infiniteAmmo : Bool
  , ammo : Int
  , ammoGivenByBonus : Int
  , baseLatency : Float
  , latency : Float
  , miniatureIndex : Int
  -- , projectileType : ProjectileType
  , weaponType : WeaponType
  }


gunWeapon : Weapon
gunWeapon =
  { name = "Pistolet"
  , infiniteAmmo = True
  , ammo = 0
  , ammoGivenByBonus = 0
  , baseLatency = 5
  , latency = 0
  , miniatureIndex = 0
  -- , projectileType = Bullet
  , weaponType = Gun
  }


-- fire : Game -> Weapon -> Game
-- fire game weapon =
--   case weapon.projectileType of
--     Bullet ->
--       { game | projectiles = bulletProjectile :: game.projectiles }
--
--     Grenade ->
--       { game | projectiles = grenadeProjectile :: game.projectiles }
--
--     Rocket ->
--       { game | projectiles = rocketProjectile :: game.projectiles }
--
--     ShotgunBullet ->
--       { game | projectiles = shotgunProjectile :: game.projectiles }
--
--     SmokeGrenade ->
--       { game | projectiles = smokeGrenadeProjectile :: game.projectiles }


fire : Game -> Weapon -> Game
fire game weapon =
  case weapon.weaponType of

    Dynamite ->
      { game | blocks = dynamiteBlock :: game.blocks }

    FlameThrower ->
      game

    Grenade ->
      { game | projectiles = grenadeProjectile :: game.projectiles }

    Gun ->
      { game | projectiles = bulletProjectile :: game.projectiles }

    Mine ->
      { game | blocks = mineBlock :: game.blocks }

    RocketLauncher ->
      { game | projectiles = rocketProjectile :: game.projectiles }

    Shotgun ->
      { game | projectiles = shotgunProjectile :: game.projectiles }

    SmokeGrenade ->
      { game | projectiles = smokeGrenadeProjectile :: game.projectiles }

    SubmachineGun ->
      game
