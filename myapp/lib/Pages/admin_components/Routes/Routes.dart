import 'package:flutter/material.dart';
import 'package:myapp/Pages/admin_components/Routes/ShowRoute.dart';
import 'package:myapp/Pages/admin_components/Routes/RouteAdd.dart';
import 'package:myapp/Pages/admin_components/apis.dart';

class Routes extends StatefulWidget {
  const Routes({Key? key}) : super(key: key);

  @override
  State<Routes> createState() => _RoutesState();
}

class _RoutesState extends State<Routes> {
  List<String> routesNames = [];
  List<String> routesIds = [];
  List<String> Ids = [];
  List<String> filteredRoutes = [];
  bool isDataLoaded = false;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchRoutes();
  }

  void fetchRoutes() async {
    if (!isDataLoaded) {
      try {
        final routesData = await RouteApi.getRoutes();
        setState(() {
          routesNames = routesData['routeNames'] ?? [];
          routesIds = routesData['routeIds'] ?? [];
          Ids = routesData['ids'] ?? [];
          filteredRoutes = routesNames;
          isDataLoaded = true;
        });
      } catch (e) {
        print('Error fetching routes: $e');
      }
    }
  }

  void navigateToRoutesViewPage(
      String routesId, String routesName, String Ids) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ShowRoute(routesId: routesId, routesName: routesName, Ids: Ids),
      ),
    );
  }

  void onSearchTextChanged(String text) {
    setState(() {
      filteredRoutes = routesNames
          .where((route) => route.toLowerCase().contains(text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Routes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: RouteSearchDelegate(
                    routes: routesNames, routesIds: routesIds),
              );
            },
          ),
        ],
      ),
      body: isDataLoaded
          ? Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: filteredRoutes.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            navigateToRoutesViewPage(routesIds[index],
                                filteredRoutes[index], Ids[index]);
                          },
                          child: ListTile(
                            title: Text(filteredRoutes[index]),
                          ),
                        );
                      },
                    ),
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RouteAdd(
                              onRouteAdded: () {
                                fetchRoutes();
                              },
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: const Text("Add a route"),
                    ),
                  ),
                ],
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

class RouteSearchDelegate extends SearchDelegate<String> {
  final List<String> routes;
  final List<String> routesIds;

  RouteSearchDelegate({required this.routes, required this.routesIds});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? routes
        : routes
            .where((route) => route.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestionList[index]),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ShowRoute(
                  routesId: routesIds[index],
                  routesName: suggestionList[index],
                  Ids: routesIds[index],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
