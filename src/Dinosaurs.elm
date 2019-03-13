module Dinosaurs exposing (Dinosaur, DinosaurType(..), dinos)


type DinosaurType
    = Herbivore
    | Carnivore


type alias Dinosaur =
    { name : String
    , dinosaurType : DinosaurType
    , basePrice : Int
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
    [ { name = "Chasmosaurus"
      , dinosaurType = Herbivore
      , basePrice = 250000
      , baseRating = 50
      , grassland = 1440
      , forest = 193
      , populationMin = 3
      , populationMax = 11
      , socialMin = 3
      , socialMax = 5
      }
    , { name = "Pentaceratops"
      , dinosaurType = Herbivore
      , basePrice = 350000
      , baseRating = 53
      , grassland = 1738
      , forest = 240
      , populationMin = 3
      , populationMax = 9
      , socialMin = 3
      , socialMax = 5
      }
    , { name = "Sinoceratops"
      , dinosaurType = Herbivore
      , basePrice = 241000
      , baseRating = 42
      , grassland = 1968
      , forest = 330
      , populationMin = 3
      , populationMax = 16
      , socialMin = 2
      , socialMax = 7
      }
    , { name = "Torosaurus"
      , dinosaurType = Herbivore
      , basePrice = 340000
      , baseRating = 47
      , grassland = 1282
      , forest = 257
      , populationMin = 2
      , populationMax = 13
      , socialMin = 2
      , socialMax = 5
      }
    , { name = "Triceratops"
      , dinosaurType = Herbivore
      , basePrice = 230000
      , baseRating = 39
      , grassland = 2418
      , forest = 631
      , populationMin = 1
      , populationMax = 16
      , socialMin = 1
      , socialMax = 6
      }
    , { name = "Styracosaurus"
      , dinosaurType = Herbivore
      , basePrice = 315000
      , baseRating = 41
      , grassland = 1244
      , forest = 178
      , populationMin = 2
      , populationMax = 14
      , socialMin = 2
      , socialMax = 5
      }
    , { name = "Corythosaurus"
      , dinosaurType = Herbivore
      , basePrice = 145000
      , baseRating = 27
      , grassland = 1244
      , forest = 457
      , populationMin = 2
      , populationMax = 24
      , socialMin = 2
      , socialMax = 13
      }
    , { name = "Dracorex"
      , dinosaurType = Herbivore
      , basePrice = 150000
      , baseRating = 32
      , grassland = 1694
      , forest = 631
      , populationMin = 2
      , populationMax = 12
      , socialMin = 2
      , socialMax = 8
      }
    , { name = "Edmontosaurus"
      , dinosaurType = Herbivore
      , basePrice = 170000
      , baseRating = 23
      , grassland = 1828
      , forest = 833
      , populationMin = 1
      , populationMax = 25
      , socialMin = 1
      , socialMax = 15
      }
    , { name = "Iguanodon"
      , dinosaurType = Herbivore
      , basePrice = 300000
      , baseRating = 48
      , grassland = 1828
      , forest = 833
      , populationMin = 1
      , populationMax = 20
      , socialMin = 1
      , socialMax = 10
      }
    , { name = "Maiasaura"
      , dinosaurType = Herbivore
      , basePrice = 165000
      , baseRating = 32
      , grassland = 1650
      , forest = 1098
      , populationMin = 4
      , populationMax = 23
      , socialMin = 4
      , socialMax = 12
      }
    , { name = "Muttaburrasaurus"
      , dinosaurType = Herbivore
      , basePrice = 225000
      , baseRating = 38
      , grassland = 1481
      , forest = 994
      , populationMin = 6
      , populationMax = 20
      , socialMin = 6
      , socialMax = 12
      }
    , { name = "Pachycephalosaurus"
      , dinosaurType = Herbivore
      , basePrice = 195000
      , baseRating = 39
      , grassland = 3150
      , forest = 714
      , populationMin = 3
      , populationMax = 10
      , socialMin = 3
      , socialMax = 6
      }
    , { name = "Parasaurolophus"
      , dinosaurType = Herbivore
      , basePrice = 180000
      , baseRating = 38
      , grassland = 1650
      , forest = 772
      , populationMin = 4
      , populationMax = 21
      , socialMin = 4
      , socialMax = 14
      }
    , { name = "Tsintaosaurus"
      , dinosaurType = Herbivore
      , basePrice = 200000
      , baseRating = 33
      , grassland = 2064
      , forest = 772
      , populationMin = 4
      , populationMax = 22
      , socialMin = 4
      , socialMax = 15
      }
    , { name = "Archaeornithomimus"
      , dinosaurType = Herbivore
      , basePrice = 70000
      , baseRating = 17
      , grassland = 658
      , forest = 73
      , populationMin = 0
      , populationMax = 21
      , socialMin = 1
      , socialMax = 16
      }
    , { name = "Gallimimus"
      , dinosaurType = Herbivore
      , basePrice = 80000
      , baseRating = 12
      , grassland = 391
      , forest = 56
      , populationMin = 0
      , populationMax = 23
      , socialMin = 1
      , socialMax = 18
      }
    , { name = "Struthiomimus"
      , dinosaurType = Herbivore
      , basePrice = 30000
      , baseRating = 9
      , grassland = 178
      , forest = 41
      , populationMin = 0
      , populationMax = 25
      , socialMin = 1
      , socialMax = 20
      }
    , { name = "Stygimoloch"
      , dinosaurType = Herbivore
      , basePrice = 188000
      , baseRating = 36
      , grassland = 1921
      , forest = 686
      , populationMin = 2
      , populationMax = 14
      , socialMin = 4
      , socialMax = 12
      }
    , { name = "Apatosaurus"
      , dinosaurType = Herbivore
      , basePrice = 851000
      , baseRating = 135
      , grassland = 6688
      , forest = 5761
      , populationMin = 0
      , populationMax = 22
      , socialMin = 3
      , socialMax = 7
      }
    , { name = "Brachiosaurus"
      , dinosaurType = Herbivore
      , basePrice = 784000
      , baseRating = 140
      , grassland = 12600
      , forest = 12600
      , populationMin = 0
      , populationMax = 25
      , socialMin = 1
      , socialMax = 5
      }
    , { name = "Camarasaurus"
      , dinosaurType = Herbivore
      , basePrice = 678000
      , baseRating = 128
      , grassland = 6174
      , forest = 17572
      , populationMin = 0
      , populationMax = 23
      , socialMin = 2
      , socialMax = 7
      }
    , { name = "Diplodocus"
      , dinosaurType = Herbivore
      , basePrice = 625000
      , baseRating = 122
      , grassland = 10864
      , forest = 2914
      , populationMin = 0
      , populationMax = 24
      , socialMin = 1
      , socialMax = 8
      }
    , { name = "Dreadnoughtus"
      , dinosaurType = Herbivore
      , basePrice = 850000
      , baseRating = 165
      , grassland = 17857
      , forest = 6428
      , populationMin = 0
      , populationMax = 15
      , socialMin = 1
      , socialMax = 3
      }
    , { name = "Mamenchisaurus"
      , dinosaurType = Herbivore
      , basePrice = 891000
      , baseRating = 162
      , grassland = 6776
      , forest = 18433
      , populationMin = 0
      , populationMax = 25
      , socialMin = 2
      , socialMax = 4
      }
    , { name = "Ankylosaurus"
      , dinosaurType = Herbivore
      , basePrice = 315000
      , baseRating = 60
      , grassland = 686
      , forest = 686
      , populationMin = 0
      , populationMax = 8
      , socialMin = 1
      , socialMax = 4
      }
    , { name = "Chungkingosaurus"
      , dinosaurType = Herbivore
      , basePrice = 275000
      , baseRating = 42
      , grassland = 4114
      , forest = 2688
      , populationMin = 2
      , populationMax = 18
      , socialMin = 2
      , socialMax = 12
      }
    , { name = "Crichtonsaurus"
      , dinosaurType = Herbivore
      , basePrice = 290000
      , baseRating = 57
      , grassland = 1522
      , forest = 178
      , populationMin = 0
      , populationMax = 8
      , socialMin = 1
      , socialMax = 5
      }
    , { name = "Gigantspinosaurus"
      , dinosaurType = Herbivore
      , basePrice = 370000
      , baseRating = 48
      , grassland = 3031
      , forest = 2418
      , populationMin = 4
      , populationMax = 16
      , socialMin = 4
      , socialMax = 10
      }
    , { name = "Huayangosaurus"
      , dinosaurType = Herbivore
      , basePrice = 210000
      , baseRating = 38
      , grassland = 3648
      , forest = 3090
      , populationMin = 1
      , populationMax = 20
      , socialMin = 1
      , socialMax = 13
      }
    , { name = "Kentrosaurus"
      , dinosaurType = Herbivore
      , basePrice = 310000
      , baseRating = 44
      , grassland = 4903
      , forest = 3332
      , populationMin = 3
      , populationMax = 17
      , socialMin = 3
      , socialMax = 11
      }
    , { name = "Nodosaurus"
      , dinosaurType = Herbivore
      , basePrice = 335000
      , baseRating = 63
      , grassland = 224
      , forest = 193
      , populationMin = 0
      , populationMax = 7
      , socialMin = 1
      , socialMax = 4
      }
    , { name = "Polacanthus"
      , dinosaurType = Herbivore
      , basePrice = 350000
      , baseRating = 65
      , grassland = 1694
      , forest = 4
      , populationMin = 0
      , populationMax = 6
      , socialMin = 1
      , socialMax = 3
      }
    , { name = "Sauropelta"
      , dinosaurType = Herbivore
      , basePrice = 355000
      , baseRating = 68
      , grassland = 2744
      , forest = 2
      , populationMin = 0
      , populationMax = 4
      , socialMin = 1
      , socialMax = 2
      }
    , { name = "Stegosaurus"
      , dinosaurType = Herbivore
      , basePrice = 320000
      , baseRating = 51
      , grassland = 5362
      , forest = 3520
      , populationMin = 5
      , populationMax = 15
      , socialMin = 5
      , socialMax = 9
      }
    ]
        |> List.sortBy .name
