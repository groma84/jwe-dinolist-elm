module Main exposing (Model, Msg(..), init, main, update, view)

--import Element exposing (..)
--import Element.Input exposing (..)

import Browser
import Dinosaurs exposing (..)
import Html exposing (..)
import Html.Attributes exposing (alt, checked, class, for, height, id, max, min, name, src, step, style, type_, width)
import Html.Events exposing (onClick)



---- MODEL ----


type alias Model =
    { filteredDinos : List Dinosaur
    , showHerbivores : Bool
    , showCarnivores : Bool
    , showPescavores : Bool
    , socialMinimumLower : Int
    , socialMinimumUpper : Int
    , socialMaximumLower : Int
    , socialMaximumUpper : Int
    , populationMinimumLower : Int
    , populationMinimumUpper : Int
    , populationMaximumLower : Int
    , populationMaximumUpper : Int
    , grassland : Int
    , forest : Int
    }


init : ( Model, Cmd Msg )
init =
    let
        socialMinimum =
            List.map .socialMin dinos
                |> List.sort
                |> List.minimum
                |> Maybe.withDefault 1

        socialMaximum =
            List.map .socialMax dinos
                |> List.sort
                |> List.maximum
                |> Maybe.withDefault 50

        populationMinimum =
            List.map .populationMin dinos
                |> List.sort
                |> List.minimum
                |> Maybe.withDefault 1

        populationMaximum =
            List.map .populationMax dinos
                |> List.sort
                |> List.maximum
                |> Maybe.withDefault 50

        grasslandMaximum =
            List.map .grassland dinos
                |> List.sort
                |> List.maximum
                |> Maybe.withDefault 25000

        forestMaximum =
            List.map .forest dinos
                |> List.sort
                |> List.maximum
                |> Maybe.withDefault 25000
    in
    ( { filteredDinos = dinos
      , showHerbivores = True
      , showCarnivores = True
      , showPescavores = True
      , socialMinimumLower = socialMinimum
      , socialMinimumUpper = socialMaximum
      , socialMaximumLower = socialMinimum
      , socialMaximumUpper = socialMaximum
      , populationMinimumLower = populationMinimum
      , populationMinimumUpper = populationMaximum
      , populationMaximumLower = populationMinimum
      , populationMaximumUpper = populationMaximum
      , grassland = grasslandMaximum
      , forest = forestMaximum
      }
    , Cmd.none
    )



---- UPDATE ----


type alias Filter =
    Dinosaur -> Bool


filterByType : DinosaurType -> Dinosaur -> Bool
filterByType dinosaurType dinosaur =
    dinosaur.dinosaurType == dinosaurType


isWithinBoundariesFilter : Int -> Int -> (Dinosaur -> Int) -> Dinosaur -> Bool
isWithinBoundariesFilter lowerLimit upperLimit valueSelector dino =
    let
        value =
            valueSelector dino
    in
    value >= lowerLimit && value <= upperLimit


createFilters : Model -> List Filter
createFilters model =
    let
        keepAll =
            \_ -> True

        keepNone =
            \_ -> False

        typeFilter =
            let
                herbiFilterFn =
                    if model.showHerbivores then
                        filterByType Herbivore

                    else
                        keepNone

                carniFilterFn =
                    if model.showCarnivores then
                        filterByType Carnivore

                    else
                        keepNone

                pescaFilterFn =
                    if model.showPescavores then
                        filterByType Pescavore

                    else
                        keepNone
            in
            \dino -> herbiFilterFn dino || carniFilterFn dino || pescaFilterFn dino
    in
    [ typeFilter
    , isWithinBoundariesFilter model.socialMinimumLower model.socialMinimumUpper .socialMin
    , isWithinBoundariesFilter model.socialMaximumLower model.socialMaximumUpper .socialMax
    , isWithinBoundariesFilter model.populationMinimumLower model.populationMinimumUpper .populationMin
    , isWithinBoundariesFilter model.populationMaximumLower model.populationMaximumUpper .populationMax
    , isWithinBoundariesFilter 1 model.grassland .grassland
    , isWithinBoundariesFilter 1 model.forest .forest
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
    | SocialMinimumLowerChanged Float
    | SocialMinimumUpperChanged Float
    | SocialMaximumLowerChanged Float
    | SocialMaximumUpperChanged Float
    | PopulationMinimumLowerChanged Float
    | PopulationMinimumUpperChanged Float
    | PopulationMaximumLowerChanged Float
    | PopulationMaximumUpperChanged Float
    | GrasslandChanged Float
    | ForestChanged Float
    | ShowTypeChanged DinosaurType


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        updateFilteredDinos filtersChanged =
            ( { filtersChanged | filteredDinos = filterDinos dinos filtersChanged }, Cmd.none )
    in
    case msg of
        NoOp ->
            ( model, Cmd.none )

        ShowHerbivoresChanged active ->
            { model | showHerbivores = active }
                |> updateFilteredDinos

        ShowCarnivoresChanged active ->
            { model | showCarnivores = active }
                |> updateFilteredDinos

        SocialMinimumLowerChanged newVal ->
            { model | socialMinimumLower = round newVal }
                |> updateFilteredDinos

        SocialMinimumUpperChanged newVal ->
            { model | socialMinimumUpper = round newVal }
                |> updateFilteredDinos

        SocialMaximumLowerChanged newVal ->
            { model | socialMaximumLower = round newVal }
                |> updateFilteredDinos

        SocialMaximumUpperChanged newVal ->
            { model | socialMaximumUpper = round newVal }
                |> updateFilteredDinos

        PopulationMinimumLowerChanged newVal ->
            { model | populationMinimumLower = round newVal }
                |> updateFilteredDinos

        PopulationMinimumUpperChanged newVal ->
            { model | populationMinimumUpper = round newVal }
                |> updateFilteredDinos

        PopulationMaximumLowerChanged newVal ->
            { model | populationMaximumLower = round newVal }
                |> updateFilteredDinos

        PopulationMaximumUpperChanged newVal ->
            { model | populationMaximumUpper = round newVal }
                |> updateFilteredDinos

        GrasslandChanged newVal ->
            { model | grassland = round newVal }
                |> updateFilteredDinos

        ForestChanged newVal ->
            { model | forest = round newVal }
                |> updateFilteredDinos

        ShowTypeChanged dinosaurType ->
            let
                filterChangedModel =
                    case dinosaurType of
                        Herbivore ->
                            { model | showHerbivores = not model.showHerbivores }

                        Carnivore ->
                            { model | showCarnivores = not model.showCarnivores }

                        Pescavore ->
                            { model | showPescavores = not model.showPescavores }
            in
            filterChangedModel |> updateFilteredDinos



---- VIEW ----


dinoTypeToString : DinosaurType -> String
dinoTypeToString dinoType =
    case dinoType of
        Herbivore ->
            "Herbivore"

        Carnivore ->
            "Carnivore"

        Pescavore ->
            "Pescavore"


dinoTypeToImage : DinosaurType -> String
dinoTypeToImage dinoType =
    case dinoType of
        Herbivore ->
            "%PUBLIC_URL%/1f33f.svg"

        Carnivore ->
            "%PUBLIC_URL%/1f969.svg"

        Pescavore ->
            "%PUBLIC_URL%/1f41f.svg"


bigImage : String -> String -> Html Msg
bigImage srcUrl altText =
    let
        attrs =
            [ src srcUrl, alt altText ]

        sizeAttrs =
            [ width 50, height 50 ]
    in
    img (List.concat [ attrs, sizeAttrs ]) []


smallImageWithText : String -> String -> Html Msg
smallImageWithText srcUrl altText =
    let
        attrs =
            [ src srcUrl, alt altText ]

        sizeAttrs =
            [ width 25, height 25 ]
    in
    img (List.concat [ attrs, sizeAttrs ]) []


fixedWidth rem =
    style "width" (String.fromInt rem ++ "rem")


fixedWidthText rem txt textAlign =
    span [ style "display" "inline-block", style "text-align" textAlign, fixedWidth rem ] [ text txt ]


fixedWidthTextRightAligned rem txt =
    fixedWidthText rem txt "right"


fixedWidthTextCenterAligned rem txt =
    fixedWidthText rem txt "center"


fromTo from to =
    [ fixedWidthTextRightAligned 1 (String.fromInt from)
    , fixedWidthTextCenterAligned 1 " - "
    , fixedWidthTextRightAligned 1 (String.fromInt to)
    ]


iconAndContent svg altText content =
    span []
        [ smallImageWithText ("%PUBLIC_URL%/" ++ svg ++ ".svg") altText
        , content
        ]


createRow : Dinosaur -> Html Msg
createRow dino =
    li [ style "display" "flex", style "align-items" "center" ]
        [ div [ fixedWidth 10 ]
            [ span []
                [ text dino.name
                ]
            ]
        , div [ style "padding" "0 1rem" ]
            [ bigImage (dinoTypeToImage dino.dinosaurType) (dinoTypeToString dino.dinosaurType) ]
        , div [ style "padding" "0 1rem" ]
            [ div [ style "display" "flex", style "flex-direction" "column" ]
                [ iconAndContent "1f495" "Social min-max" (span [ fixedWidth 3 ] (fromTo dino.socialMin dino.socialMax))
                , iconAndContent "1f465" "Population min-max" (span [ fixedWidth 3 ] (fromTo dino.populationMin dino.populationMax))
                ]
            ]
        , div [ style "padding" "0 1rem" ]
            [ div [ style "display" "flex", style "flex-direction" "column" ]
                [ iconAndContent "1f33e" "Grassland" (fixedWidthTextRightAligned 3 (String.fromInt dino.grassland))
                , iconAndContent "1f332" "Forest" (fixedWidthTextRightAligned 3 (String.fromInt dino.forest))
                ]
            ]
        , div [ style "padding" "0 1rem" ]
            [ div [ style "display" "flex", style "flex-direction" "column" ]
                [ iconAndContent "2b50" "Base Rating" (fixedWidthTextRightAligned 3 (String.fromInt dino.baseRating))
                , iconAndContent "1f4b5" "Cost in k$" (fixedWidthTextRightAligned 3 (String.fromInt (dino.basePrice // 1000) ++ "k"))
                ]
            ]
        ]



-- TODO


filtersView : Model -> Html Msg
filtersView model =
    let
        checkbox inputId isChecked dinosaurType txt =
            label [ for inputId ]
                [ input [ type_ "checkbox", id inputId, checked isChecked, onClick (ShowTypeChanged dinosaurType) ] []
                , text txt
                ]
    in
    form []
        [ fieldset [ name "dinosaur-type-filter" ]
            [ checkbox "herbivore-checkbox" model.showHerbivores Herbivore "Herbivores"
            , checkbox "carnivore-checkbox" model.showCarnivores Carnivore "Carnivores"
            , checkbox "pescavore-checkbox" model.showPescavores Pescavore "Pescavores"
            ]
        ]


view : Model -> Html Msg
view model =
    {-
       UI-Idee:
       Man hat pro Zahl einen - und einen + Button - so ist es auch auf dem Smartphone gut bedienbar
       Die Zahlen springen dann immer eine Zahl weiter in der Liste der möglichen Zahlen - man hat also keine 1er oder so,
       sondern je nachdem, was eben die nächste bei einem Dino vorkommende Zahl ist. Vielleicht mit einem Zipper?
       Ggf. müssen zu nah zusammen liegende Zahlen gebündelt werden, wenn sich mehrere Dinos nur um ein paar m² unterscheiden.
       Über eine platzsparende Anordnung muss ich mir allerdings noch Gedanken machen.

       Außerdem zu tun: Daten für nächsten Patch aktualisieren, alle Hybriden freischalten und eintragen, Claire-Dinos eintragen,
       neue Symbole für Fleischfresser, Pflanzenfresser, Fischfresser einführen - auch als Filter mit je einer Checkbox.
    -}
    div []
        [ div []
            [ filtersView model
            ]
        , div []
            [ ol [ class "main-dino-list" ]
                (List.map createRow model.filteredDinos)
            ]
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
