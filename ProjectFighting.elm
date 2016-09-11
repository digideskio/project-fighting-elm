import Color
import AnimationFrame
import Keyboard
import Mouse

import Projectile

import Html.App

import Html exposing (Html, div, text)
import Element exposing (Element, toHtml)
import Collage exposing (Form, collage, rect, filled)
import Time exposing (Time)
import Keyboard exposing (KeyCode)

import Projectile exposing (Projectile)
import Block exposing (Block)
import Player exposing (Player)
import Particle exposing (Particle)


scene : List Form -> Element
scene elements = collage 500 500 elements


player : Form
player = filled (Color.rgb 30 19 67) (rect 14 15)


renderScene : Element
renderScene = scene [ player ]


-- render : GameData -> Html GameMsg
-- render d = div [ ] [ toHtml renderScene ]


type alias Map = List (List Int)


type GameState
  = Running
  | Paused
  | GameOver


type alias Model =
  { width : Int
  , height : Int
  , map : Map
  , projectiles : List Projectile
  , blocks : List Block
  , players : List Player
  , particles : List Particle
  }


type Msg
  = NothingHappened
  | Tick Time
  | KeyDown KeyCode
  | KeyUp KeyCode
  | MouseClick Mouse.Position
  | MouseMove Mouse.Position


init : (Model, Cmd Msg)
init =
  (
    { width = 500
    , height = 500
    , map = [ ]
    , projectiles = [ ]
    , blocks = [ ]
    , players = [ ]
    , particles = [ ]
    }
  , Cmd.none)


view : Model -> Html b
view model = text (toString model)


update : Msg -> Model -> (Model, Cmd Msg)
update msg d =
  case msg of
    Tick t ->
      let
        dt = t / 1000
        projectiles = Projectile.updateProjectiles dt d.projectiles
      in
        ({ d | projectiles = projectiles }, Cmd.none)

    MouseMove position ->
      (d, Cmd.none)

    MouseClick position ->
      let
        projectile = Projectile.bulletProjectile
      in
        ({ d | projectiles = projectile :: d.projectiles }, Cmd.none)

    _ ->
      (d, Cmd.none)


subscriptions : Model -> Sub Msg
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
