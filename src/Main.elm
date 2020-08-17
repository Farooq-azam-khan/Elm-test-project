module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import List



-- Main


main =
    Browser.sandbox { init = init, update = update, view = view }



-- Model


type alias Model =
    { counter : Int, content : String, authors : List String, newAuthor : String }


init : Model
init =
    { counter = 0, content = "", authors = [], newAuthor = "" }



-- update


type Msg
    = Increment
    | Decrement
    | Reset
    | Increment10
    | AddAuthor
    | UpdateAuthorName String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            { model | counter = model.counter + 1, content = "Added 1" }

        Increment10 ->
            { model | counter = model.counter + 10, content = "Added 10" }

        Decrement ->
            if model.counter - 1 >= 0 then
                { model | counter = model.counter - 1, content = "deleted 1" }

            else
                { model | counter = model.counter, content = "Cannot go below zero" }

        UpdateAuthorName name ->
            { model | newAuthor = name }

        AddAuthor ->
            { model | authors = model.newAuthor :: model.authors, newAuthor = "" }

        Reset ->
            { model | counter = 0, content = "Reset" }



-- view


showAuthor name acc =
    li [] [ text name ] :: acc


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick Decrement ] [ text "-" ]
        , div [] [ text (String.fromInt model.counter) ]
        , div [] [ text model.content ]
        , button [ onClick Increment ] [ text "+" ]
        , button [ onClick Increment10 ] [ text "+10" ]
        , button [ onClick Reset ] [ text "Reset" ]
        , h1 [] [ text "Authors" ]
        , input [ placeholder "Author Name", value model.newAuthor, Html.Events.onInput UpdateAuthorName ] []
        , button [ onClick AddAuthor ] [ text "Add Author" ]
        , ul []
            (List.foldl showAuthor [] model.authors)
        ]
