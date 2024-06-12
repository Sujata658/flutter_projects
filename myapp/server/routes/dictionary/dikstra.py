from geopy.distance import great_circle
import networkx as nx
import matplotlib.pyplot as plt
# done up to
# lat long
check_list = []
multiple_labels = {}

routes = [{
    "_id": {
        "$oid": "658aeff1a94e5a96649b04d1"
    },
    "id": "L2NBP",
    "name": "Lagankhel-New Bus Park",
    "start": "1",
    "end": "19",
    "stops_list": [
        "1",
        "2",
        "3",
        "4",
        "5",
        "6",
        "7",
        "8",
        "9",
        "10",
        "11",
        "12",
        "13",
        "14",
        "15",
        "16",
        "17",
        "18",
        "19"
    ]
},
    {
    "_id": {
        "$oid": "658aeff1a94e5a96649b04d5"
    },
    "id": "T2B",
    "name": "Thankot-Buddhanilkantha",
    "start": "30",
    "end": "62",
    "stops_list": [
        "30",
        "31",
        "32",
        "33",
        "34",
        "35",
        "36",
        "50",
        "51",
        "52",
        "53",
        "54",
        "55",
        "56",
        "57",
        "58",
        "59",
        "60",
        "61",
        "62"
    ]
},
    {
    "_id": {
        "$oid": "658aeff1a94e5a96649b04d2"
    },
    "id": "G2RP",
    "name": "Godawari-Ratnapark",
    "start": "20",
    "end": "29",
    "stops_list": [
        "20",
        "21",
        "22",
        "23",
        "24",
        "25",
        "26",
        "27",
        "28",
        "1",
        "2",
        "3",
        "4",
        "5",
        "6",
        "7",
        "8",
        "29"
    ]
},

]

stops = [
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a77f"
        },
        "stopsId": 1,
        "name": "Lagankhel",
        "lat": 27.6746476,
        "long": 85.3222147
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a780"
        },
        "stopsId": 2,
        "name": "Kumaripati",
        "lat": 27.6794377,
        "long": 85.3227903
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a781"
        },
        "stopsId": 3,
        "name": "Jawalakhel",
        "lat": 27.6831256,
        "long": 85.321608
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a782"
        },
        "stopsId": 4,
        "name": "Pulchowk",
        "lat": 27.6831597,
        "long": 85.318085
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a783"
        },
        "stopsId": 5,
        "name": "Harihar Bhawan",
        "lat": 27.6781726,
        "long": 85.3175585
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a784"
        },
        "stopsId": 6,
        "name": "Kupondole",
        "lat": 27.6823837,
        "long": 85.3187517
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a785"
        },
        "stopsId": 7,
        "name": "Tripureshwor",
        "lat": 27.7013773,
        "long": 85.3205436
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a786"
        },
        "stopsId": 8,
        "name": "RNAC",
        "lat": 27.6950562,
        "long": 85.322688
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a787"
        },
        "stopsId": 9,
        "name": "Jamal",
        "lat": 27.7090207,
        "long": 85.3124691
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a788"
        },
        "stopsId": 10,
        "name": "Lainchaur",
        "lat": 27.7142223,
        "long": 85.3140652
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a789"
        },
        "stopsId": 11,
        "name": "Lazimpat",
        "lat": 27.7170193,
        "long": 85.3191596
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a78a"
        },
        "stopsId": 12,
        "name": "Panipokhari",
        "lat": 27.7191596,
        "long": 85.3170633
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a78b"
        },
        "stopsId": 13,
        "name": "Rastrapati Bhawan",
        "lat": 27.7204587,
        "long": 85.316257
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a78c"
        },
        "stopsId": 14,
        "name": "Teaching Hospital",
        "lat": 27.7215719,
        "long": 85.3154513
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a78d"
        },
        "stopsId": 15,
        "name": "Narayan Gopal Chowk",
        "lat": 27.7226945,
        "long": 85.3146448
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a78e"
        },
        "stopsId": 16,
        "name": "Basundhara",
        "lat": 27.7251316,
        "long": 85.3122925
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a78f"
        },
        "stopsId": 17,
        "name": "Samakhusi",
        "lat": 27.7277871,
        "long": 85.3104329
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a790"
        },
        "stopsId": 18,
        "name": "Gongabu",
        "lat": 27.729126,
        "long": 85.308829
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a791"
        },
        "stopsId": 19,
        "name": "New Bus Park",
        "lat": 27.719691,
        "long": 85.307306
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a792"
        },
        "stopsId": 20,
        "name": "Godawari",
        "lat": 27.594886,
        "long": 85.391375
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a793"
        },
        "stopsId": 21,
        "name": "Taukhel",
        "lat": 27.608187,
        "long": 85.389308
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a794"
        },
        "stopsId": 22,
        "name": "Hadegau",
        "lat": 27.619064,
        "long": 85.386473
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a795"
        },
        "stopsId": 23,
        "name": "Badegau",
        "lat": 27.629277,
        "long": 85.384785
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a796"
        },
        "stopsId": 24,
        "name": "Thaiba",
        "lat": 27.640113,
        "long": 85.37896
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a797"
        },
        "stopsId": 25,
        "name": "Harisiddhi",
        "lat": 27.650564,
        "long": 85.377254
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a798"
        },
        "stopsId": 26,
        "name": "Hattiban",
        "lat": 27.659259,
        "long": 85.370981
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a799"
        },
        "stopsId": 27,
        "name": "Khumaltar",
        "lat": 27.66869,
        "long": 85.364566
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a79a"
        },
        "stopsId": 28,
        "name": "Satdobato",
        "lat": 27.678956,
        "long": 85.361025
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a79b"
        },
        "stopsId": 29,
        "name": "Ratnapark",
        "lat": 27.7041289,
        "long": 85.3100125
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a79c"
        },
        "stopsId": 30,
        "name": "Thankot",
        "lat": 27.6785132,
        "long": 85.2719772
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a79d"
        },
        "stopsId": 31,
        "name": "Tribhuvan Park",
        "lat": 27.6828499,
        "long": 85.2839356
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a79e"
        },
        "stopsId": 32,
        "name": "Checkpost",
        "lat": 27.6908657,
        "long": 85.2805758
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a79f"
        },
        "stopsId": 33,
        "name": "Satungal",
        "lat": 27.6975394,
        "long": 85.2712391
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a7a0"
        },
        "stopsId": 34,
        "name": "Naikap",
        "lat": 27.6982718,
        "long": 85.2537813
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a7a1"
        },
        "stopsId": 35,
        "name": "Dhunge Adda",
        "lat": 27.6885535,
        "long": 85.2394868
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a7a2"
        },
        "stopsId": 36,
        "name": "Kalanki",
        "lat": 27.6930593,
        "long": 85.2389415
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a7a3"
        },
        "stopsId": 37,
        "name": "Rabi Bhawan",
        "lat": 27.7057822,
        "long": 85.335768
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a7a4"
        },
        "stopsId": 38,
        "name": "Soaltee Mod",
        "lat": 27.7157937,
        "long": 85.3249751
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a7a5"
        },
        "stopsId": 39,
        "name": "Kalimati",
        "lat": 27.6985841,
        "long": 85.3122882
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a7a6"
        },
        "stopsId": 40,
        "name": "Teku",
        "lat": 27.6955689,
        "long": 85.3111567
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a7a7"
        },
        "stopsId": 41,
        "name": "Singh Durbar",
        "lat": 27.7083775,
        "long": 85.3137277
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a7a8"
        },
        "stopsId": 42,
        "name": "Maitighar",
        "lat": 27.7049963,
        "long": 85.3184427
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a7a9"
        },
        "stopsId": 43,
        "name": "Babar Mahal",
        "lat": 27.7119711,
        "long": 85.3235732
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a7aa"
        },
        "stopsId": 44,
        "name": "Bijuli Bazar",
        "lat": 27.7144176,
        "long": 85.3208566
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a7ab"
        },
        "stopsId": 45,
        "name": "New Baneshwor",
        "lat": 27.6932261,
        "long": 85.3232921
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a7ac"
        },
        "stopsId": 46,
        "name": "Shantinagar",
        "lat": 27.6878865,
        "long": 85.3269707
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a7ad"
        },
        "stopsId": 47,
        "name": "Tinkune",
        "lat": 27.6862351,
        "long": 85.3348675
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a7ae"
        },
        "stopsId": 48,
        "name": "Sinamangal",
        "lat": 27.6899892,
        "long": 85.3478112
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a7af"
        },
        "stopsId": 49,
        "name": "Airport",
        "lat": 27.6966285,
        "long": 85.3598491
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a7b0"
        },
        "stopsId": 50,
        "name": "Bafal",
        "lat": 27.716624,
        "long": 85.277974
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a7b1"
        },
        "stopsId": 51,
        "name": "Sitapaila",
        "lat": 27.720829,
        "long": 85.281744
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a7b2"
        },
        "stopsId": 52,
        "name": "Swayambhu",
        "lat": 27.714889,
        "long": 85.289862
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a7b3"
        },
        "stopsId": 53,
        "name": "Banasthali",
        "lat": 27.716991,
        "long": 85.299671
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a7b4"
        },
        "stopsId": 54,
        "name": "Balaju",
        "lat": 27.717827,
        "long": 85.301852
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a7b5"
        },
        "stopsId": 55,
        "name": "Gangalal Hospital",
        "lat": 27.736276,
        "long": 85.341829
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a7b6"
        },
        "stopsId": 56,
        "name": "Neuro Hospital",
        "lat": 27.736335,
        "long": 85.332961
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a7b7"
        },
        "stopsId": 57,
        "name": "Golfutar",
        "lat": 27.738278,
        "long": 85.324514
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a7b8"
        },
        "stopsId": 58,
        "name": "Telecom Chowk",
        "lat": 27.743508,
        "long": 85.319707
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a7b9"
        },
        "stopsId": 59,
        "name": "Hattigauda",
        "lat": 27.749237,
        "long": 85.315933
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a7ba"
        },
        "stopsId": 60,
        "name": "Chapli",
        "lat": 27.754978,
        "long": 85.311672
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a7bb"
        },
        "stopsId": 61,
        "name": "Deuba Chowk",
        "lat": 27.760772,
        "long": 85.307439
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a7bc"
        },
        "stopsId": 62,
        "name": "Buddhanilkantha",
        "lat": 27.7654,
        "long": 85.3653
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a7bd"
        },
        "stopsId": 63,
        "name": "Lamatar",
        "lat": 27.639138,
        "long": 85.355637
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a7be"
        },
        "stopsId": 64,
        "name": "Dhungin",
        "lat": 27.643521,
        "long": 85.354212
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a7bf"
        },
        "stopsId": 65,
        "name": "Lubhu",
        "lat": 27.648079,
        "long": 85.353037
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a7c0"
        },
        "stopsId": 66,
        "name": "Sanagau",
        "lat": 27.655462,
        "long": 85.350753
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a7c1"
        },
        "stopsId": 67,
        "name": "KamalpokhariL",
        "lat": 27.6563,
        "long": 85.342
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a7c2"
        },
        "stopsId": 68,
        "name": "Krishna Mandir",
        "lat": 27.713868,
        "long": 85.328655
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a7c3"
        },
        "stopsId": 69,
        "name": "KIST Hospital",
        "lat": 27.675243,
        "long": 85.322714
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a7c4"
        },
        "stopsId": 70,
        "name": "Gwarko",
        "lat": 27.659808,
        "long": 85.324073
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a7c5"
        },
        "stopsId": 71,
        "name": "BNB Hospital",
        "lat": 27.676995,
        "long": 85.316787
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a7c6"
        },
        "stopsId": 72,
        "name": "Patan dhoka",
        "lat": 27.677575,
        "long": 85.320633
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a7c7"
        },
        "stopsId": 73,
        "name": "Thapathali",
        "lat": 27.691164,
        "long": 85.319769
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a7c8"
        },
        "stopsId": 74,
        "name": "Bhadrakali",
        "lat": 27.697258,
        "long": 85.317766
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a7c9"
        },
        "stopsId": 75,
        "name": "Kamladi",
        "lat": 27.706199,
        "long": 85.318623
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a7ca"
        },
        "stopsId": 76,
        "name": "KamalpokhariK",
        "lat": 27.710076,
        "long": 85.329151
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a7cb"
        },
        "stopsId": 77,
        "name": "Gyaneshwor",
        "lat": 27.705778,
        "long": 85.332986
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a7cc"
        },
        "stopsId": 78,
        "name": "Ratopul",
        "lat": 27.706367,
        "long": 85.340769
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a7cd"
        },
        "stopsId": 79,
        "name": "Gaushala",
        "lat": 27.705024,
        "long": 85.348358
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a7ce"
        },
        "stopsId": 80,
        "name": "Jay Bageshwori",
        "lat": 27.706994,
        "long": 85.351505
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a7cf"
        },
        "stopsId": 81,
        "name": "Mitra Park",
        "lat": 27.700076,
        "long": 85.358462
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a7d0"
        },
        "stopsId": 82,
        "name": "Chabahil",
        "lat": 27.720717,
        "long": 85.350294
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a7d1"
        },
        "stopsId": 83,
        "name": "Chuchepati",
        "lat": 27.726978,
        "long": 85.347907
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a7d2"
        },
        "stopsId": 84,
        "name": "Tusal",
        "lat": 27.727961,
        "long": 85.342735
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a7d3"
        },
        "stopsId": 85,
        "name": "Boudha",
        "lat": 27.721366,
        "long": 85.361828
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a7d4"
        },
        "stopsId": 86,
        "name": "Jorpati",
        "lat": 27.728049,
        "long": 85.396267
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a7d5"
        },
        "stopsId": 87,
        "name": "Narayantar",
        "lat": 27.731708,
        "long": 85.396863
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a7d6"
        },
        "stopsId": 88,
        "name": "Dakshin Dhoka",
        "lat": 27.735731,
        "long": 85.382088
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a7d7"
        },
        "stopsId": 89,
        "name": "Lele",
        "lat": 27.5833,
        "long": 85.3471
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a7d8"
        },
        "stopsId": 90,
        "name": "Tika Bhairav",
        "lat": 27.5858,
        "long": 85.3445
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a7d9"
        },
        "stopsId": 91,
        "name": "Takhal",
        "lat": 27.5875,
        "long": 85.3386
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a7da"
        },
        "stopsId": 92,
        "name": "Pyan Gaun",
        "lat": 27.591,
        "long": 85.3321
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a7db"
        },
        "stopsId": 93,
        "name": "Thecho",
        "lat": 27.5957,
        "long": 85.3256
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a7dc"
        },
        "stopsId": 94,
        "name": "Sunakothi",
        "lat": 27.6044,
        "long": 85.3166
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a7dd"
        },
        "stopsId": 95,
        "name": "Dholahiti",
        "lat": 27.6141,
        "long": 85.3083
    },
    {
        "_id": {
            "$oid": "65caf846fc49d1b35761a7de"
        },
        "stopsId": 96,
        "name": "Chapagaun Dobato",
        "lat": 27.6672,
        "long": 85.3208
    }
]

edges_by_route = {}
all_edges = {}
pos_dict = {}

# Iterate through routes to create edges and positions
for route in routes:
    stops_list = route['stops_list']
    edges = []

    # Iterate through stops to create edges
    for i in range(len(stops_list) - 1):
        edge = [stops_list[i], stops_list[i + 1]]
        edges.append(edge)

    # Add edges to the dictionary with route_id as key
    edges_by_route[route['id']] = edges

    # Calculate positions based on the stop coordinates
    for stop_id in stops_list:
        if stop_id not in pos_dict:
            stop_coords = (stops[int(stop_id) - 1]['lat'],
                           stops[int(stop_id) - 1]['long'])
            pos_dict[stop_id] = stop_coords

# Combine edges from all routes into a new dictionary
for route_id, edges in edges_by_route.items():
    # print("992", edges_by_route.items())
    all_edges[route_id] = edges

# print("all edges", all_edges)

# Create a graph
graph = nx.Graph()

# Add edges to the graph

for route_id, edges in all_edges.items():
    print("inside ", check_list)
    for ed in edges:
        if (ed in check_list):  # 1,2

            multiple_labels[ed] = []

        else:
            print("adding to the graph")
            check_list.append(edges)
            graph.add_edges_from(edges, label=route_id)

    print(check_list)
    print("edges", edges)


# Function to calculate the distance between two stops


def calculate_distance(stop1, stop2):
    coords1 = (stops[stop1 - 1]['lat'], stops[stop1 - 1]['long'])
    coords2 = (stops[stop2 - 1]['lat'], stops[stop2 - 1]['long'])
    return great_circle(coords1, coords2).meters

# Function to find the shortest path and distance between two stops


def find_shortest_path(graph, start_stop, end_stop):
    try:
        path = nx.shortest_path(graph, source=str(
            start_stop), target=str(end_stop), weight='distance')
        distance = sum(calculate_distance(int(path[i]), int(
            path[i + 1])) for i in range(len(path) - 1))

        # Find routes for each edge in the path
        routes = [graph[path[i]][path[i + 1]]['label']
                  for i in range(len(path) - 1)]

        return path, distance, routes
    except nx.NetworkXNoPath:
        raise ValueError(f"No path found between stops {
                         start_stop} and {end_stop}")


# Example: Find shortest path, distance, and routes between Lagankhel (stop 1) and Kumaripati (stop 2)
start_stop = 20
end_stop = 16

# Print the result
try:
    shortest_path, shortest_distance, shortest_routes = find_shortest_path(
        graph, start_stop, end_stop)
    print("Shortest Path:", shortest_path)
    print("Shortest Distance:", shortest_distance, "meters")
    print("Routes:", shortest_routes)

    # Visualize the graph with the shortest path highlighted
    nx.draw(graph, pos=pos_dict, with_labels=False,
            node_size=100, node_color='lightblue')

    # Highlight the shortest path
    highlighted_edges = [(shortest_path[i], shortest_path[i + 1])
                         for i in range(len(shortest_path) - 1)]
    nx.draw_networkx_edges(
        graph, pos=pos_dict, edgelist=highlighted_edges, edge_color='red', width=2)

    # Add labels to nodes
    node_labels = {node: stops[int(node) - 1]['name'] for node in pos_dict}
    nx.draw_networkx_labels(
        graph, pos=pos_dict, labels=node_labels, font_size=8, font_color='black')

    # Add labels to edges
    labels = nx.get_edge_attributes(graph, 'label')
    for edge, label in labels.items():
        x, y = (pos_dict[edge[0]][0] + pos_dict[edge[1]][0]) / \
            2, (pos_dict[edge[0]][1] + pos_dict[edge[1]][1]) / 2
        plt.text(x, y, label, fontsize=8, ha='center', va='center')

    plt.show()

except ValueError as e:
    print(e)
