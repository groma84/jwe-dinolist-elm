module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Element exposing (..)
import Element.Input exposing (..)
import Html exposing (Html, div, h1, img, text)
import Html.Attributes exposing (src)


type DinosaurType
    = Herbivore
    | Carnivore



---- MODEL ----


type alias Dinosaur =
    { name : String
    , food : DinosaurType
    , socialMin : Int
    , socialMax : Int
    , populationMin : Int
    , populationMax : Int
    , grassland : Int
    , forest : Int
    , baseRating : Int
    }


dinos : List Dinosaur
dinos =
    [ { name = "Fakeosaurus 1"
      , food = Herbivore
      , socialMin = 1
      , socialMax = 4
      , populationMin = 0
      , populationMax = 12
      , grassland = 1234
      , forest = 432
      , baseRating = 12
      }
    , { name = "Fakeosaurus 2"
      , food = Herbivore
      , socialMin = 11
      , socialMax = 44
      , populationMin = 4
      , populationMax = 123
      , grassland = 12345
      , forest = 4321
      , baseRating = 120
      }
    , { name = "Fakeosaurus 3"
      , food = Carnivore
      , socialMin = 1
      , socialMax = 1
      , populationMin = 1
      , populationMax = 8
      , grassland = 12340
      , forest = 4320
      , baseRating = 210
      }
    ]


type alias Model =
    { filteredDinos : List Dinosaur
    , showHerbivores : Bool
    , showCarnivores : Bool
    }


init : ( Model, Cmd Msg )
init =
    ( { filteredDinos = dinos
      , showHerbivores = True
      , showCarnivores = True
      }
    , Cmd.none
    )



---- UPDATE ----


type alias Filter =
    Dinosaur -> Bool


filterByType : DinosaurType -> Dinosaur -> Bool
filterByType dinosaurType dinosaur =
    dinosaur.food == dinosaurType


createFilters : Model -> List Filter
createFilters model =
    let
        keepAll =
            \_ -> True

        keepNone =
            \_ -> False

        typeFilter =
            case ( model.showHerbivores, model.showCarnivores ) of
                ( True, True ) ->
                    keepAll

                ( True, False ) ->
                    filterByType Herbivore

                ( False, True ) ->
                    filterByType Carnivore

                ( False, False ) ->
                    keepNone
    in
    [ typeFilter
    ]


filterDinos : List Dinosaur -> Model -> List Dinosaur
filterDinos allDinos model =
    let
        filters =
            createFilters model
    in
    List.foldl List.filter allDinos filters


type Msg
    = NoOp
    | ShowHerbivoresChanged Bool
    | ShowCarnivoresChanged Bool


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        ShowHerbivoresChanged active ->
            let
                filtersChanged =
                    { model | showHerbivores = active }
            in
            ( { filtersChanged | filteredDinos = filterDinos dinos filtersChanged }, Cmd.none )

        ShowCarnivoresChanged active ->
            let
                filtersChanged =
                    { model | showCarnivores = active }
            in
            ( { filtersChanged | filteredDinos = filterDinos dinos filtersChanged }, Cmd.none )



---- VIEW ----


dinoTypeToString : DinosaurType -> String
dinoTypeToString dinoType =
    case dinoType of
        Herbivore ->
            "Herbivore"

        Carnivore ->
            "Carnivore"


view : Model -> Html Msg
view model =
    let
        resultsTable =
            Element.table []
                { data = model.filteredDinos
                , columns =
                    [ { header = Element.text "Name"
                      , width = fill
                      , view =
                            \dino ->
                                Element.text dino.name
                      }
                    , { header = Element.text "Type"
                      , width = fill
                      , view =
                            \dino ->
                                Element.text (dinoTypeToString dino.food)
                      }
                    , { header = Element.text "Social Min."
                      , width = fill
                      , view =
                            \dino ->
                                Element.text (String.fromInt dino.socialMin)
                      }
                    , { header = Element.text "Social Max."
                      , width = fill
                      , view =
                            \dino ->
                                Element.text (String.fromInt dino.socialMax)
                      }
                    ]
                }

        filterConfiguration =
            Element.column []
                [ Element.Input.checkbox []
                    { onChange = ShowHerbivoresChanged
                    , icon = Element.Input.defaultCheckbox
                    , checked = model.showHerbivores
                    , label = Element.Input.labelRight [] (Element.text "Herbivores")
                    }
                , Element.Input.checkbox []
                    { onChange = ShowCarnivoresChanged
                    , icon = Element.Input.defaultCheckbox
                    , checked = model.showCarnivores
                    , label = Element.Input.labelRight [] (Element.text "Carnivores")
                    }
                ]
    in
    Element.layout [] <|
        Element.wrappedRow []
            [ Element.column [] [ filterConfiguration ]
            , Element.column [] [ resultsTable ]
            ]



---- SUBSCRIPTIONS ----
---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
