from geopy.distance import great_circle
import networkx as nx
import matplotlib.pyplot as plt
# done up to lat long

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

]


# Your routes and stops data

# Initialize dictionaries to store edges and positions
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
    all_edges[route_id] = edges

# Create a graph
graph = nx.Graph()

# Add edges to the graph
for route_id, edges in all_edges.items():
    graph.add_edges_from(edges, label=route_id)

# Visualize the graph
labels = nx.get_edge_attributes(graph, 'label')

# Draw nodes at positions based on latitude and longitude
nx.draw(graph, pos=pos_dict, with_labels=False,
        node_size=100, node_color='lightblue')

# Add labels to nodes
node_labels = {node: stops[int(node) - 1]['name'] for node in pos_dict}
nx.draw_networkx_labels(graph, pos=pos_dict,
                        labels=node_labels, font_size=8, font_color='black')

# Add labels to edges
for edge, label in labels.items():
    x, y = (pos_dict[edge[0]][0] + pos_dict[edge[1]][0]) / \
        2, (pos_dict[edge[0]][1] + pos_dict[edge[1]][1]) / 2
    plt.text(x, y, label, fontsize=8, ha='center', va='center')

plt.show()
