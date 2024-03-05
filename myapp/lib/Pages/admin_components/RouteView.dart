import 'package:flutter/material.dart';
import 'package:myapp/Pages/admin_components/RouteEdit.dart';
import 'package:myapp/Pages/admin_components/apis.dart';

class RouteView extends StatefulWidget {
  const RouteView({Key? key}) : super(key: key);

  @override
  State<RouteView> createState() => _RouteViewState();
}

class _RouteViewState extends State<RouteView> {
  List<String> routesNames = [];
  List<String> routesIds = [];
  bool isDataLoaded = false;

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
          isDataLoaded = true;
        });
      } catch (e) {
        print('Error fetching routes: $e');
      }
    }
  }

  void navigateToRoutesEditPage(String routesId, String routesName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            RouteEditPage(routesId: routesId, routesName: routesName),
      ),
    );
  }

  void navigateToRoutesViewPage(String routesId, String routesName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ShowRoute(routesId: routesId, routesName: routesName),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Routes')),
      body: isDataLoaded
          ? Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: routesNames.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          print('Selected route: ${routesIds[index]}');
                          navigateToRoutesViewPage(
                              routesIds[index], routesNames[index]);
                        },
                        child: ListTile(
                          title: Text(routesNames[index]),
                        ),
                      );
                    },
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
