import matplotlib.pyplot as plt
import networkx as nx

routes = [
    {
        "_id": {"$oid": "658aeff1a94e5a96649b04d1"},
        "id": "L2NBP",
        "name": "Lagankhel-New Bus Park",
        "start": "1",
        "end": "17",
        "stops_list": ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17"]
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
    }
    # Add other routes here
]


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
}, {
    "_id": {
        "$oid": "65c74c9a3e021640988ce4de"
    },
    "id": 1000,
    "lat": 27.75555,
    "lon": 85.35,
    "name": "test stop karki",
    "__v": 0
}]


    # Check if stop is part of any edge
    for edge, data in all_edges.items():
        if stop_id in edge:
            all_edges[edge]['stops'].append(stop_id)

# Print the combined edges
for edge, data in all_edges.items():
    print(f"Edge: {edge}, Routes: {data['routes']}, Stops: {data['stops']}")

graph = nx.Graph()

# Add edges to the graph
for edge, data in all_edges.items():
    routes_str = ', '.join(data['routes'])
    graph.add_edge(int(edge[0]), int(edge[1]), label=routes_str)

# Get labels after adding edges to the graph
labels = nx.get_edge_attributes(graph, 'label')

# Visualize the graph using positions based on latitude and longitude
nx.draw(graph, pos=pos_dict, with_labels=True,
        labels={stop_id: stops_dict[stop_id]['name']
                for stop_id in stops_dict},
        node_size=350, node_color='lightblue', font_size=6)

# Add labels to edges
for edge, label in labels.items():
    x, y = (pos_dict[edge[0]][0] + pos_dict[edge[1]][0]) / \
        2, (pos_dict[edge[0]][1] + pos_dict[edge[1]][1]) / 2
    plt.text(x, y, label, fontsize=6, ha='center', va='center', color='red')

plt.show()
