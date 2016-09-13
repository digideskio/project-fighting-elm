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
  , weaponType : WeaponType
  }


newWeapon : Weapon
newWeapon =
  { name = "--"
  , infiniteAmmo = False
  , ammo = 0
  , ammoGivenByBonus = 0
  , baseLatency = 5
  , latency = 0
  , miniatureIndex = 0
  , weaponType = Gun
  }


newGun : Weapon
newGun =
  { newWeapon
    | name = "Pistolet"
    , infiniteAmmo = True
    , baseLatency = 5
    , miniatureIndex = 0
    , weaponType = Gun
    }
