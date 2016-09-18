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


newDynamite : Weapon
newDynamite =
  { newWeapon
    | name = "Dynamite"
    , ammo = 1000
    , baseLatency = 5
    , miniatureIndex = 0
    , weaponType = Dynamite
    }


newFlameThrower : Weapon
newFlameThrower =
  { newWeapon
    | name = "Lance-flammes"
    , ammo = 1000
    , baseLatency = 5
    , miniatureIndex = 0
    , weaponType = FlameThrower
    }


newGrenade : Weapon
newGrenade =
  { newWeapon
    | name = "Grenade"
    , ammo = 1000
    , baseLatency = 5
    , miniatureIndex = 0
    , weaponType = Grenade
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


newMine : Weapon
newMine =
  { newWeapon
    | name = "Mine"
    , ammo = 1000
    , baseLatency = 5
    , miniatureIndex = 0
    , weaponType = Mine
    }


newRocketLauncher : Weapon
newRocketLauncher =
  { newWeapon
    | name = "Lance-roquettes"
    , ammo = 1000
    , baseLatency = 5
    , miniatureIndex = 0
    , weaponType = RocketLauncher
    }


newShotgun : Weapon
newShotgun =
  { newWeapon
    | name = "Fusil à pompe"
    , ammo = 1000
    , baseLatency = 5
    , miniatureIndex = 0
    , weaponType = Shotgun
    }


newSmokeGrenade : Weapon
newSmokeGrenade =
  { newWeapon
    | name = "Fumigène"
    , ammo = 1000
    , baseLatency = 5
    , miniatureIndex = 0
    , weaponType = SmokeGrenade
    }


newSubmachineGun : Weapon
newSubmachineGun =
  { newWeapon
    | name = "Mitraillette"
    , ammo = 1000
    , baseLatency = 5
    , miniatureIndex = 0
    , weaponType = SubmachineGun
    }


updateWeapon : Float -> Weapon -> Weapon
updateWeapon dt ({ latency } as weapon) =
  let
    latencyMinusDt = latency - dt

    newLatency =
      if latencyMinusDt < 0 then
        latencyMinusDt
      else
        0
  in
    { weapon
      | latency = newLatency
      }


resetWeaponLatency : Weapon -> Weapon
resetWeaponLatency ({ latency, baseLatency } as weapon) =
  { weapon
    | latency = baseLatency
    }
