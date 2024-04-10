
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
