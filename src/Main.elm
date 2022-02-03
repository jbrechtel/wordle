module Main exposing (..)
import Browser
import Html exposing (Html, button, div, text, input)
import Html.Events exposing (onClick, onInput)
import List exposing (map)
main =
  Browser.sandbox { init = Model 0 "" [], update = update, view = view }

type alias Model = { total : Int 
                   , name : String
                   , list : List String
                   }
type Msg = Increment Int  | Decrement Int | ChangeName String | UpdateList

update : Msg -> Model -> Model
update msg model =
  case msg of
    Increment i ->
      Model (model.total + i) model.name model.list

    Decrement i ->
      Model (model.total - i) model.name model.list
    
    ChangeName newname->
      Model (model.total) newname model.list

    UpdateList ->
      Model model.total model.name (model.name :: model.list)

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