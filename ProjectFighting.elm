import Color
import AnimationFrame
import Keyboard
import Mouse

import Projectile
import Key

import Html.App

import Html exposing (Html, div, text)
import Element exposing (Element, toHtml)
import Collage exposing (Form, collage, rect, filled)
import Time exposing (Time)
import Keyboard exposing (KeyCode)

import Projectile exposing (Projectile)
import Block exposing (Block)
import Player exposing (Player, newPlayer)
import Particle exposing (Particle)


scene : List Form -> Element
scene elements = collage 500 500 elements


player : Form
player = filled (Color.rgb 30 19 67) (rect 14 15)


renderScene : Element
renderScene = scene [ player ]


getCurrentPlayer : Model -> Int -> Player
getCurrentPlayer game id =
  let
    player = List.filter (\p -> p.id == id) game.players |> List.head
  in
    case player of
      Just p ->
        p

      Nothing ->
        newPlayer game.uid


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
  , currentPlayerId : Int
  , uid : Int
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
    , players = [ newPlayer 0 ]
    , particles = [ ]
    , currentPlayerId = 0
    , uid = 0
    }
  , Cmd.none)


view : Model -> Html b
view model = text (toString model)


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Tick t ->
      let
        dt = t / 1000
        projectiles = Projectile.updateProjectiles dt model.projectiles
        players = Player.updatePlayers dt model.players
      in
        ({ model
          | projectiles = projectiles
          , players = players
        }, Cmd.none)

    KeyDown keyCode ->
        (keyDown keyCode model, Cmd.none)

    KeyUp keyCode ->
        (keyUp keyCode model, Cmd.none)

    MouseMove position ->
      (model, Cmd.none)

    MouseClick position ->
      let
        projectile = Projectile.bulletProjectile
      in
        ({ model | projectiles = projectile :: model.projectiles }, Cmd.none)

    _ ->
      (model, Cmd.none)


keyUp : KeyCode -> Model -> Model
keyUp keyCode model =
  let
    updatePlayer player =
      if player.id == model.currentPlayerId then
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

    players = List.map updatePlayer model.players
  in
    { model | players = players }


keyDown : KeyCode -> Model -> Model
keyDown keyCode model =
  let
    updatePlayer player =
      if player.id == model.currentPlayerId then
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

    players = List.map updatePlayer model.players
  in
    { model | players = players }


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
