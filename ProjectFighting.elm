module ProjectFighting exposing (..)

-- import Color
import AnimationFrame
import Keyboard
import Mouse

import Projectile
import Key
import Game
import Weapon

import Html.App

import Html exposing (Html, div, text)
-- import Element exposing (Element, toHtml)
-- import Collage exposing (Form, collage, rect, filled)
import Time exposing (Time)
import Keyboard exposing (KeyCode)

import Projectile exposing (Projectile)
import Block exposing (Block)
import Player exposing (Player, newPlayer)
import Particle exposing (Particle)

import Game exposing (Game)


-- scene : List Form -> Element
-- scene elements = collage 500 500 elements


-- player : Form
-- player = filled (Color.rgb 30 19 67) (rect 14 15)


-- renderScene : Element
-- renderScene = scene [ player ]

-- render : GameData -> Html GameMsg
-- render d = div [ ] [ toHtml renderScene ]


type Msg
  = NothingHappened
  | Tick Time
  | KeyDown KeyCode
  | KeyUp KeyCode
  | MouseClick Mouse.Position
  | MouseMove Mouse.Position


init : (Game, Cmd Msg)
init =
  (
    { width = 500
    , height = 500
    , map = [ ]
    , projectiles = [ ]
    , blocks = [ ]
    , players = [ newPlayer 0 ]
    , particles = [ ]
    , currentPlayerId = 0
    , uid = 0
    }
  , Cmd.none)


view : Game -> Html b
view game = text (toString game)


update : Msg -> Game -> (Game, Cmd Msg)
update msg game =
  case msg of
    Tick t ->
      let
        dt = t / 1000
        projectiles = Projectile.updateProjectiles dt game.projectiles
        players = Player.updatePlayers dt game.players
      in
        ({ game
          | projectiles = projectiles
          , players = players
        }, Cmd.none)

    KeyDown keyCode ->
        (keyDown keyCode game, Cmd.none)

    KeyUp keyCode ->
        (keyUp keyCode game, Cmd.none)

    MouseMove position ->
      (game, Cmd.none)

    MouseClick position ->
      (Game.fire game position Weapon.newGun, Cmd.none)

    _ ->
      (game, Cmd.none)


keyUp : KeyCode -> Game -> Game
keyUp keyCode game =
  let
    updatePlayer player =
      if player.id == game.currentPlayerId then
        case Key.fromCode keyCode of
          Key.ArrowLeft ->
            { player | dx = 0 }

          Key.ArrowUp ->
            { player | dy = 0 }

          Key.ArrowRight ->
            { player | dx = 0 }

          Key.ArrowDown ->
            { player | dy = 0 }

          _ ->
            player
      else
        player

    players = List.map updatePlayer game.players
  in
    { game | players = players }


keyDown : KeyCode -> Game -> Game
keyDown keyCode game =
  let
    updatePlayer player =
      if player.id == game.currentPlayerId then
        case Key.fromCode keyCode of
          Key.ArrowLeft ->
            { player | dx = -1 }

          Key.ArrowUp ->
            { player | dy = -1 }

          Key.ArrowRight ->
            { player | dx = 1 }

          Key.ArrowDown ->
            { player | dy = 1 }

          _ ->
            player
      else
        player

    players = List.map updatePlayer game.players
  in
    { game | players = players }


subscriptions : Game -> Sub Msg
subscriptions d =
  Sub.batch
    [ AnimationFrame.diffs Tick
    , Keyboard.downs KeyDown
    , Keyboard.ups KeyUp
    , Mouse.clicks MouseClick
    , Mouse.moves MouseMove
    ]


main : Program Never
main = Html.App.program
  { init = init
  , view = view
  , update = update
  , subscriptions = subscriptions
  }
