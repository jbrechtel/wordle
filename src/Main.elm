module Main exposing (..)
import Browser
import Html exposing (Html, button, div, text, input)
import Html.Events exposing (onClick, onInput)
import List exposing (map)

main : Program () Model Msg
main =
  Browser.sandbox { init = initialModel, update = update, view = view }

initialModel : Model
initialModel =
  { total = 0
  , name = ""
  , list = []
  }

type alias Model = { total : Int
                   , name : String
                   , list : List String
                   }
type Msg = Increment Int  | Decrement Int | ChangeName String | UpdateList

update : Msg -> Model -> Model
update msg model =
  case msg of
    Increment i ->
      { model | total = model.total + i }

    Decrement i ->
      { model | total = model.total - i }

    ChangeName newname->
      { model | name = newname }

    UpdateList ->
      { model | list = model.name :: model.list }

view : Model -> Html Msg
view model =
  div []
    [ button [ onClick (Decrement 1) ] [ text "-" ]
    , div [] [ text (String.fromInt model.total) ]
    , div [] [ text (model.name) ]
    , div [] (map viewname model.list)
    , button [ onClick (Increment 1) ] [ text "+" ]
    , button [ onClick (Increment 10) ] [ text "+10" ]
    , input [onInput ChangeName] []
    , button [onClick UpdateList] [text "Update"]
    ]
viewname : String -> Html Msg
viewname name =
  div [] [ text name ]
