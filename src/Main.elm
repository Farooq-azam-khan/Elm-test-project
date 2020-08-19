module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import List
import Round



-- Main


main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }



-- Model


type alias Author =
    { name : String }


type alias Book =
    { name : String, authors : List Author, pages : Int, chapters : Int }


type alias Model =
    { books : List Book, authors : List Author, show_authors : Bool }


init : Model
init =
    { books =
        [ book1
        , book2
        ]
    , authors = [ Author "George R. R. Martin" ]
    , show_authors = False
    }


book1 =
    Book "A Game of Thrones" [ Author "George R. R. Martin" ] 800 50


book2 =
    Book "A Storm of Swords" [ Author "George R. R. Martin" ] 1128 90



-- update


type Msg
    = ShowAuthors


update : Msg -> Model -> Model
update msg model =
    case msg of
        ShowAuthors ->
            { model | show_authors = not model.show_authors }


view : Model -> Html Msg
view model =
    div [ class "bg-gray-200", class "text-gray-800" ]
        [ renderBooks model.books
        , if model.show_authors then
            renderAuthors model.authors

          else
            button
                [ onClick ShowAuthors
                , class "bg-blue-800 hover:bg-blue-900 text-white px-4 py-2 text-sm font-semibold"
                ]
                [ text "Show Author" ]
        ]


renderBooks : List Book -> Html Msg
renderBooks books =
    div [ class "md:container mx-auto" ]
        [ h1 []
            [ text "Books" ]
        , div
            [ class "flex justify-center space-x-10 space-y-2 items-center" ]
            (List.map renderBookRow books)
        ]


renderBookRow : Book -> Html Msg
renderBookRow book =
    div [ class "bg-gray-800 hover:bg-gray-900 rounded-lg shadow-xl space-x-3 text-gray-200 px-3 py-2" ]
        [ h3 [ class "text-xl" ] [ text book.name ]
        , ul [ class "flex items-center  w-full space-x-2" ] (List.map (\author -> li [] [ a [ href "#", class "hover:underline hover:text-orange-400" ] [ text author.name ] ]) book.authors)
        , p [ class "flex items-center jusitfy-between space-x-2 w-full" ]
            [ span [] [ text (String.fromInt book.pages ++ " (" ++ Round.round 3 (100 / Basics.toFloat book.pages) ++ "%)") ]
            , span [ class "text-xs text-gray-400 font-semibold uppercase" ] [ text "pages" ]
            ]
        , p [ class "flex items-center jusitfy-between space-x-2 w-full" ]
            [ span [] [ text (String.fromInt book.chapters ++ " (" ++ Round.round 3 (100 / Basics.toFloat book.chapters) ++ "%)") ]
            , span [ class "text-xs text-gray-400 font-semibold uppercase" ] [ text "chaps" ]
            ]
        ]


renderAuthors : List Author -> Html Msg
renderAuthors authors =
    div []
        [ h1 [] [ text "Autors" ]
        , div [] [ ul [] (List.map renderAuthor authors) ]
        ]


renderAuthor author =
    li [] [ text author.name ]
