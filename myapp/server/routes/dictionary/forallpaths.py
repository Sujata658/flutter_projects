import networkx as nx
import matplotlib.pyplot as plt
from geopy.distance import great_circle

# Your existing code

# Create a graph
graph = nx.Graph()

# Add edges to the graph
for route_id, edges in all_edges.items():
    graph.add_edges_from(edges, label=route_id)

# Function to calculate the distance between two stops


def calculate_distance(stop1, stop2):
    coords1 = (stops[stop1 - 1]['lat'], stops[stop1 - 1]['long'])
    coords2 = (stops[stop2 - 1]['lat'], stops[stop2 - 1]['long'])
    return great_circle(coords1, coords2).meters

# Function to find all paths between two stops


def find_all_paths(graph, start_stop, end_stop):
    if start_stop not in graph or end_stop not in graph:
        raise nx.NodeNotFound(
            "Either source {} or target {} is not in G".format(start_stop, end_stop))

    all_paths = list(nx.all_shortest_paths(
        graph, source=start_stop, target=end_stop, weight='distance'))
    distances = [sum(calculate_distance(path[i], path[i + 1])
                     for i in range(len(path) - 1)) for path in all_paths]

    return list(zip(all_paths, distances))


# Example: Find all paths and distances between Lagankhel (stop 1) and Kumaripati (stop 2)
start_stop = 1
end_stop = 2

# Print the result
try:
    all_paths_and_distances = find_all_paths(graph, start_stop, end_stop)
    for path, distance in all_paths_and_distances:
        print("Path:", path)
        print("Distance:", distance, "meters")
        print("---")

    # Visualize the graph
    nx.draw(graph, pos=pos_dict, with_labels=False,
            node_size=100, node_color='lightblue')

    # Add labels to nodes
    nx.draw_networkx_labels(
        graph, pos=pos_dict, labels=node_labels, font_size=8, font_color='black')

    # Add labels to edges
    labels = nx.get_edge_attributes(graph, 'label')
    for edge, label in labels.items():
        x, y = (pos_dict[edge[0]][0] + pos_dict[edge[1]][0]) / \
            2, (pos_dict[edge[0]][1] + pos_dict[edge[1]][1]) / 2
        plt.text(x, y, label, fontsize=8, ha='center', va='center')

    plt.show()

except nx.NodeNotFound as e:
    print(e)
