module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Dinosaurs exposing (..)
import Element exposing (..)
import Element.Input exposing (..)
import Html exposing (Html, div, h1, img, text)
import Html.Attributes exposing (src)



---- MODEL ----


absoluteSocialMinimum =
    1


absoluteSocialMaximum =
    25


absolutePopulationMinimum =
    0


absolutePopulationMaximum =
    25


absoluteGrasslandMinimum =
    1


absoluteGrasslandMaximum =
    25000


absoluteForestMinimum =
    1


absoluteForestMaximum =
    25000


type alias Model =
    { filteredDinos : List Dinosaur
    , showHerbivores : Bool
    , showCarnivores : Bool
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
    ( { filteredDinos = dinos
      , showHerbivores = True
      , showCarnivores = True
      , socialMinimumLower = absoluteSocialMinimum
      , socialMinimumUpper = absoluteSocialMaximum
      , socialMaximumLower = absoluteSocialMinimum
      , socialMaximumUpper = absoluteSocialMaximum
      , populationMinimumLower = absolutePopulationMinimum
      , populationMinimumUpper = absolutePopulationMaximum
      , populationMaximumLower = absolutePopulationMinimum
      , populationMaximumUpper = absolutePopulationMaximum
      , grassland = absoluteGrasslandMaximum
      , forest = absoluteForestMaximum
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



---- VIEW ----


dinoTypeToString : DinosaurType -> String
dinoTypeToString dinoType =
    case dinoType of
        Herbivore ->
            "Herbivore"

        Carnivore ->
            "Carnivore"


dinoTypeToImage : DinosaurType -> String
dinoTypeToImage dinoType =
    case dinoType of
        Herbivore ->
            "%PUBLIC_URL%/1f995.svg"

        Carnivore ->
            "%PUBLIC_URL%/1f996.svg"


view : Model -> Html Msg
view model =
    let
        resultsTable =
            let
                numberColumn heading valueFn =
                    { header = Element.text heading
                    , width = fill
                    , view =
                        \dino ->
                            Element.text (String.fromInt (valueFn dino))
                    }
            in
            Element.table []
                { data = model.filteredDinos
                , columns =
                    [ { header = Element.text "Name"
                      , width = fill
                      , view =
                            \dino ->
                                Element.paragraph [ paddingXY 0 16 ] [ Element.text dino.name ]
                      }
                    , { header = Element.text ""
                      , width = fill
                      , view =
                            \dino ->
                                Element.image [ width (Element.px 40), height (Element.px 40) ]
                                    { src = dinoTypeToImage dino.dinosaurType
                                    , description = dinoTypeToString dino.dinosaurType
                                    }
                      }
                    , { header = Element.text ""
                      , width = fill
                      , view =
                            \dino ->
                                Element.column []
                                    [ Element.row []
                                        [ Element.image [ width (Element.px 20), height (Element.px 20) ]
                                            { src = "%PUBLIC_URL%/1f495.svg"
                                            , description = "Social min-max"
                                            }
                                        , Element.text (String.fromInt dino.socialMin ++ " - " ++ String.fromInt dino.socialMax)
                                        ]
                                    , Element.row []
                                        [ Element.image [ width (Element.px 20), height (Element.px 20) ]
                                            { src = "%PUBLIC_URL%/1f465.svg"
                                            , description = "Population min-max"
                                            }
                                        , Element.text (String.fromInt dino.populationMin ++ " - " ++ String.fromInt dino.populationMax)
                                        ]
                                    ]
                      }
                    , { header = Element.text ""
                      , width = fill
                      , view =
                            \dino ->
                                Element.column []
                                    [ Element.row []
                                        [ Element.image [ width (Element.px 20), height (Element.px 20) ]
                                            { src = "%PUBLIC_URL%/1f33e.svg"
                                            , description = "Grassland"
                                            }
                                        , Element.text (String.fromInt dino.grassland)
                                        ]
                                    , Element.row []
                                        [ Element.image [ width (Element.px 20), height (Element.px 20) ]
                                            { src = "%PUBLIC_URL%/1f332.svg"
                                            , description = "Forest"
                                            }
                                        , Element.text (String.fromInt dino.forest)
                                        ]
                                    ]
                      }
                    , { header = Element.text ""
                      , width = fill
                      , view =
                            \dino ->
                                Element.column []
                                    [ Element.row []
                                        [ Element.image [ width (Element.px 20), height (Element.px 20) ]
                                            { src = "%PUBLIC_URL%/2b50.svg"
                                            , description = "Base Rating"
                                            }
                                        , Element.text (String.fromInt dino.baseRating)
                                        ]
                                    , Element.row []
                                        [ Element.image [ width (Element.px 20), height (Element.px 20) ]
                                            { src = "%PUBLIC_URL%/1f4b5.svg"
                                            , description = "Cost in k$"
                                            }
                                        , Element.text (String.fromInt dino.basePrice)
                                        ]
                                    ]
                      }
                    ]
                }

        filterConfiguration =
            let
                checkbox onChangeMsg checkedVal labelText =
                    Element.Input.checkbox []
                        { onChange = onChangeMsg
                        , icon = Element.Input.defaultCheckbox
                        , checked = checkedVal
                        , label = Element.Input.labelRight [] (Element.text labelText)
                        }

                singleSliderRow absMin absMax onChangeMsg currentValue labelText =
                    Element.Input.slider []
                        { onChange = onChangeMsg
                        , label = Element.Input.labelAbove [] (Element.text labelText)
                        , min = absMin
                        , max = absMax
                        , value = toFloat currentValue
                        , thumb = defaultThumb
                        , step = Just 1
                        }

                sliderRow absMin absMax minimumConfig maximumConfig =
                    let
                        slider onChangeMsg currentValue labelText =
                            Element.Input.slider []
                                { onChange = onChangeMsg
                                , label = Element.Input.labelAbove [] (Element.text labelText)
                                , min = absMin
                                , max = absMax
                                , value = toFloat currentValue
                                , thumb = defaultThumb
                                , step = Just 1
                                }
                    in
                    Element.row []
                        [ slider minimumConfig.onChangeMsg minimumConfig.currentValue minimumConfig.labelText
                        , slider maximumConfig.onChangeMsg maximumConfig.currentValue maximumConfig.labelText
                        ]
            in
            Element.column []
                [ checkbox ShowHerbivoresChanged model.showHerbivores "Herbivores"
                , checkbox ShowCarnivoresChanged model.showCarnivores "Carnivores"
                , sliderRow absoluteSocialMinimum
                    absoluteSocialMaximum
                    { onChangeMsg = SocialMinimumLowerChanged
                    , currentValue = model.socialMinimumLower
                    , labelText = "Social Min From:" ++ String.fromInt model.socialMinimumLower
                    }
                    { onChangeMsg = SocialMinimumUpperChanged
                    , currentValue = model.socialMinimumUpper
                    , labelText = "Social Min To:" ++ String.fromInt model.socialMinimumUpper
                    }
                , sliderRow absoluteSocialMinimum
                    absoluteSocialMaximum
                    { onChangeMsg = SocialMaximumLowerChanged
                    , currentValue = model.socialMaximumLower
                    , labelText = "Social Max From:" ++ String.fromInt model.socialMaximumLower
                    }
                    { onChangeMsg = SocialMaximumUpperChanged
                    , currentValue = model.socialMaximumUpper
                    , labelText = "Social Max To:" ++ String.fromInt model.socialMaximumUpper
                    }
                , sliderRow absolutePopulationMinimum
                    absolutePopulationMaximum
                    { onChangeMsg = PopulationMinimumLowerChanged
                    , currentValue = model.populationMinimumLower
                    , labelText = "Population Min From:" ++ String.fromInt model.populationMinimumLower
                    }
                    { onChangeMsg = PopulationMinimumUpperChanged
                    , currentValue = model.populationMinimumUpper
                    , labelText = "Population Min To:" ++ String.fromInt model.populationMinimumUpper
                    }
                , sliderRow absolutePopulationMinimum
                    absolutePopulationMaximum
                    { onChangeMsg = PopulationMaximumLowerChanged
                    , currentValue = model.populationMaximumLower
                    , labelText = "Population Max From:" ++ String.fromInt model.populationMaximumLower
                    }
                    { onChangeMsg = PopulationMaximumUpperChanged
                    , currentValue = model.populationMaximumUpper
                    , labelText = "Population Max To:" ++ String.fromInt model.populationMaximumUpper
                    }
                , singleSliderRow absoluteGrasslandMinimum absoluteGrasslandMaximum GrasslandChanged model.grassland ("Grassland avail.:" ++ String.fromInt model.grassland)
                , singleSliderRow absoluteForestMinimum absoluteForestMaximum ForestChanged model.forest ("Forest avail.:" ++ String.fromInt model.forest)
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
