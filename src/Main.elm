module Main exposing (main)

-- import Html.Events exposing (onClick, onInput)
-- import Html.Attributes exposing (..)

import Browser
import Html exposing (Html, pre, text)
import Http



-- import List
-- Main


main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }



-- Model
-- type alias Model =
--     { counter : Int, content : String, authors : List String, newAuthor : String }


type Model
    = Failure
    | Loading
    | Success String


init : () -> ( Model, Cmd Msg )
init _ =
    ( Loading
    , Http.get
        { url = "https://elm-lang.org/assets/public-opinion.txt"
        , expect = Http.expectString GotText
        }
    )



-- init =
--     { counter = 0, content = "", authors = [], newAuthor = "" }
-- update


type Msg
    = GotText (Result Http.Error String)



-- type Msg
--     = Increment
--     | Decrement
--     | Reset
--     | Increment10
--     | AddAuthor
--     | UpdateAuthorName String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotText result ->
            case result of
                Ok fullText ->
                    ( Success fullText, Cmd.none )

                Err _ ->
                    ( Failure, Cmd.none )



-- update msg model =
--     case msg of
--         Increment ->
--             { model | counter = model.counter + 1, content = "Added 1" }
--         Increment10 ->
--             { model | counter = model.counter + 10, content = "Added 10" }
--         Decrement ->
--             if model.counter - 1 >= 0 then
--                 { model | counter = model.counter - 1, content = "deleted 1" }
--             else
--                 { model | counter = model.counter, content = "Cannot go below zero" }
--         UpdateAuthorName name ->
--             { model | newAuthor = name }
--         AddAuthor ->
--             { model | authors = model.newAuthor :: model.authors, newAuthor = "" }
--         Reset ->
--             { model | counter = 0, content = "Reset" }
-- view
-- showAuthor name acc =
--     li [] [ text name ] :: acc


view : Model -> Html Msg
view model =
    case model of
        Failure ->
            text "Unable to load book."

        Loading ->
            text "laoding..."

        Success fullText ->
            pre [] [ text fullText ]



-- view model =
--     div []
--         [ button [ onClick Decrement ] [ text "-" ]
--         , div [] [ text (String.fromInt model.counter) ]
--         , div [] [ text model.content ]
--         , button [ onClick Increment ] [ text "+" ]
--         , button [ onClick Increment10 ] [ text "+10" ]
--         , button [ onClick Reset ] [ text "Reset" ]
--         , h1 [] [ text "Authors" ]
--         , input [ placeholder "Author Name", value model.newAuthor, Html.Events.onInput UpdateAuthorName ] []
--         , button [ onClick AddAuthor ] [ text "Add Author" ]
--         , ul []
--             (List.foldl showAuthor [] model.authors)
--         ]
-- subscriptions


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
