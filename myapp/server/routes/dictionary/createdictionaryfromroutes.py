# created dictionary from routes first stop
routes = [{
    "_id": {
        "$oid": "658aeff1a94e5a96649b04d1"
    },
    "id": "L2NBP",
    "name": "Lagankhel-New Bus Park",
    "start": "1",
    "end": "19",
    "stops_list": [
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
        "18"
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
        "61"
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
        "8"
    ]
},
    {
    "_id": {
        "$oid": "658aeff1a94e5a96649b04d3"
    },
    "id": "T2A",
    "name": "Thankot-Airport",
    "start": "30",
    "end": "49",
    "stops_list": [
        "31",
        "32",
        "33",
        "34",
        "35",
        "36",
        "37",
        "38",
        "39",
        "40",
        "41",
        "7",
        "8",
        "29",
        "42",
        "43",
        "44",
        "45",
        "46",
        "47",
        "48"
    ]
},
    {
    "_id": {
        "$oid": "658aeff1a94e5a96649b04d4"
    },
    "id": "L2B",
    "name": "Lagankhel-Buddhanilkantha",
    "start": "1",
    "end": "62",
    "stops_list": [
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
        "55",
        "56",
        "57",
        "58",
        "59",
        "60",
        "61"
    ]
},
    {
    "_id": {
        "$oid": "658aeff1a94e5a96649b04d6"
    },
    "id": "LA2RP",
    "name": "Lamatar-Ratnapark",
    "start": "63",
    "end": "29",
    "stops_list": [
        "64",
        "65",
        "66",
        "67",
        "68",
        "69",
        "70",
        "71",
        "28",
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
        "11"
    ]
},
    {
    "_id": {
        "$oid": "658aeff1a94e5a96649b04d7"
    },
    "id": "PD2DD",
    "name": "Patan Dhoka-Dakshin Dhoka",
    "start": "72",
    "end": "88",
    "stops_list": [
        "6",
        "73",
        "74",
        "75",
        "76",
        "77",
        "78",
        "79",
        "80",
        "81",
        "82",
        "83",
        "84",
        "85",
        "86",
        "87"
    ]
},
    {
    "_id": {
        "$oid": "658aeff1a94e5a96649b04d8"
    },
    "id": "LL2J",
    "name": "Lele-Jamal",
    "start": "89",
    "end": "9",
    "stops_list": [
        "90",
        "91",
        "92",
        "93",
        "94",
        "95",
        "96",
        "1",
        "2",
        "3",
        "4",
        "5",
        "6",
        "7",
        "8"
    ]
},
    {
    "_id": {
        "$oid": "65bcf5994024c5e0a8631a6f"
    },
    "id": "L2NBP",
    "name": "test",
    "stops_list": [
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
        "18"
    ],
    "start": "1000000",
    "end": "2000000",
    "__v": 0
},
    {
    "_id": {
        "$oid": "65bfb177ebb62649d1985ab1"
    },
    "id": "test",
    "name": "test-test",
    "stops_list": [
        "7",
        "10"
    ],
    "start": "1",
    "end": "18",
    "__v": 0
},
    {
    "_id": {
        "$oid": "65c74c14af79cae19e41af0e"
    },
    "id": "L2NBP testing",
    "name": "Lagankhel-New Bus Park but testing",
    "stops_list": [
        "5",
        "6",
        "7",
        "8",
        "9",
        "1000"
    ],
    "start": "5",
    "end": "10",
    "__v": 0
}]

edges_by_route = {}

for route in routes:
    stops_list = route['stops_list']
    edges = []

    # Iterate through stops to create edges
    for i in range(len(stops_list) - 1):
        edge = [stops_list[i], stops_list[i + 1]]
        edges.append(edge)

    # Add edges to the dictionary with route_id as key
    edges_by_route[route['id']] = edges

# Print the edges for each route
for route_id, edges in edges_by_route.items():
    print(f"Edges for Route {route_id}:")
    for edge in edges:
        print(edge)

# Combine edges from all routes into a new dictionary
all_edges = {}
for route_id, edges in edges_by_route.items():
    all_edges[route_id] = edges

# Print the combined edges
print("\nCombined Edges:")
for route_id, edges in all_edges.items():
    print(f"Edges for Route {route_id}:")
    for edge in edges:
        print(edge)
print(all_edges)
