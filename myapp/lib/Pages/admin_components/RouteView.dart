import 'package:flutter/material.dart';
import 'package:myapp/Pages/admin_components/RouteEdit.dart';
import 'package:myapp/Pages/admin_components/apis.dart';

class RouteView extends StatefulWidget {
  const RouteView({super.key});

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
        // print('Routes Data: $routesData');
        // print(routesData);
        setState(() {
          routesNames = routesData['routeNames']!;
          routesIds = routesData['routeIds']!;
          isDataLoaded = true;
        });
      } catch (e) {
        print('Error fetching routes: $e');
      }
    }
  }

  void navigateToroutesEditPage(String routesId, String routesName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            RouteEditPage(routesId: routesId, routesName: routesName),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Routes')),
      body: routesNames.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: routesNames.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(routesNames[index]),
                          trailing: ElevatedButton(
                            onPressed: () {
                              navigateToroutesEditPage(
                                  routesIds[index], routesNames[index]);
                            },
                            child: const Text('Edit'),
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
                                        )));
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red),
                          child: const Text(
                            "Add a route",
                          )),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
