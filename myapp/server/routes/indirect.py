from collections import deque

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
}]

stops = [{
    "_id": {
        "$oid": "65c0fc390e141156fc3320fd"
    },
    "id": 1,
    "name": "Lagankhel",
    "lat": 27.667292191163654,
    "lon": 85.32384361839783
},
    {
    "_id": {
        "$oid": "65c0fc390e141156fc3320fe"
    },
    "id": 2,
    "name": "Kumaripati",
    "lat": 27.670324100000002,
    "lon": 85.3210251
},
    {
    "_id": {
        "$oid": "65c0fc390e141156fc3320ff"
    },
    "id": 3,
    "name": "Jawalakhel",
    "lat": 27.673055700000003,
    "lon": 85.3134816
},
    {
    "_id": {
        "$oid": "65c0fc390e141156fc332100"
    },
    "id": 4,
    "name": "Pulchowk",
    "lat": 27.6819462,
    "lon": 85.3195355
},
    {
    "_id": {
        "$oid": "65c0fc390e141156fc332101"
    },
    "id": 5,
    "name": "Harihar Bhawan",
    "lat": 27.68002,
    "lon": 85.311643
},
    {
    "_id": {
        "$oid": "65c0fc390e141156fc332102"
    },
    "id": 6,
    "name": "Kupondole",
    "lat": 27.685245000000002,
    "lon": 85.3127221
},
    {
    "_id": {
        "$oid": "65c0fc390e141156fc332103"
    },
    "id": 7,
    "name": "Tripureshwor",
    "lat": 27.693777,
    "lon": 85.314116
},
    {
    "_id": {
        "$oid": "65c0fc390e141156fc332104"
    },
    "id": 8,
    "name": "RNAC",
    "lat": 27.7249982,
    "lon": 85.3372556
},
    {
    "_id": {
        "$oid": "65c0fc390e141156fc332105"
    },
    "id": 9,
    "name": "Jamal",
    "lat": 27.708785000000002,
    "lon": 85.315278
},
    {
    "_id": {
        "$oid": "65c0fc390e141156fc332106"
    },
    "id": 10,
    "name": "Lainchaur",
    "lat": 27.717026500000003,
    "lon": 85.3159019
},
    {
    "_id": {
        "$oid": "65c0fc390e141156fc332107"
    },
    "id": 11,
    "name": "Lazimpat",
    "lat": 27.721508200000002,
    "lon": 85.3207646
},
    {
    "_id": {
        "$oid": "65c0fc390e141156fc332108"
    },
    "id": 12,
    "name": "Panipokhari",
    "lat": 27.7292515,
    "lon": 85.32474570000001
},
    {
    "_id": {
        "$oid": "65c0fc390e141156fc332109"
    },
    "id": 13,
    "name": "Rastrapati Bhawan",
    "lat": 27.660417600000002,
    "lon": 85.37754790000001
},
    {
    "_id": {
        "$oid": "65c0fc390e141156fc33210a"
    },
    "id": 14,
    "name": "Teaching Hospital",
    "lat": 27.73451,
    "lon": 85.33073420000001
},
    {
    "_id": {
        "$oid": "65c0fc390e141156fc33210b"
    },
    "id": 15,
    "name": "Narayan Gopal Chowk",
    "lat": 27.73997,
    "lon": 85.337228
},
    {
    "_id": {
        "$oid": "65c0fc390e141156fc33210c"
    },
    "id": 16,
    "name": "Basundhara",
    "lat": 27.7406158,
    "lon": 85.3293507
},
    {
    "_id": {
        "$oid": "65c0fc390e141156fc33210d"
    },
    "id": 17,
    "name": "Samakhusi",
    "lat": 27.735594900000002,
    "lon": 85.3208828
}]


def find_indirect_routes(routes, stops, start_stop, end_stop):
    # Create a dictionary to store routes and their stops
    route_dict = {route['id']: route['stops_list'] for route in routes}

    # Create a dictionary to store the neighbors of each stop
    stop_neighbors = {}
    for route in routes:
        for i in range(len(route['stops_list']) - 1):
            current_stop = route['stops_list'][i]
            next_stop = route['stops_list'][i + 1]

            if current_stop not in stop_neighbors:
                stop_neighbors[current_stop] = set()

            stop_neighbors[current_stop].add(next_stop)

    # BFS to find the indirect route
    visited = set()
    queue = deque([(start_stop, [])])

    while queue:
        current_stop, current_path = queue.popleft()

        if current_stop == end_stop:
            return current_path + [end_stop]

        visited.add(current_stop)

        if current_stop in stop_neighbors:
            for neighbor in stop_neighbors[current_stop]:
                if neighbor not in visited:
                    queue.append((neighbor, current_path + [current_stop]))

    return None  # No indirect route found


# Example usage
start_stop_id = "1"
end_stop_id = "17"
indirect_route = find_indirect_routes(
    routes, stops, start_stop_id, end_stop_id)

if indirect_route:
    print(f"Indirect route found: {indirect_route}")
else:
    print("No indirect route found.")
