import 'package:flutter/material.dart';
import 'package:myapp/Pages/admin_components/Vehicle/ShowVehicle.dart';
import 'package:myapp/Pages/admin_components/Vehicle/VehicleEditPage.dart';
import 'package:myapp/Pages/admin_components/apis.dart';

class Vehicles extends StatefulWidget {
  const Vehicles({super.key});

  @override
  State<Vehicles> createState() => _VehiclesState();
}

class _VehiclesState extends State<Vehicles> {
  List<Map<String, dynamic>> vehicles = [];
  List<Map<String, dynamic>> filteredVehicles = [];
  bool isDataLoaded = false;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchVehicles();
  }

  void fetchVehicles() async {
    try {
      final response = await VehicleApi.getVehicles();

      setState(() {
        vehicles = response;
        filteredVehicles = vehicles;
        isDataLoaded = true;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  void navigateToVehicleEditPage(Map<String, dynamic> vehicle) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VehicleEditPage(vehicle: vehicle),
      ),
    ).then((value) {
      if (value != null && value) {
        fetchVehicles();
      }
    });
  }

  void onVehicleAdded() {
    fetchVehicles();
  }

  void filterVehicles(String query) {
    setState(() {
      filteredVehicles = vehicles
          .where((vehicle) =>
              vehicle['name'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return isDataLoaded
        ? Scaffold(
            appBar: AppBar(
              title: const Text('Vehicles'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: VehicleSearchDelegate(vehicles),
                    );
                  },
                ),
              ],
            ),
            body: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  const SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: filteredVehicles.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShowVehicle(
                                vehicle: filteredVehicles[index],
                              ),
                            ),
                          );
                        },
                        child: ListTile(
                          title: Text('${filteredVehicles[index]['name']}'),
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
                            builder: (context) => VehicleAdd(
                              onVehicleAdded: onVehicleAdded,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: const Text("Add a vehicle"),
                    ),
                  )
                ],
              ),
            ),
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}

class VehicleSearchDelegate extends SearchDelegate {
  final List<Map<String, dynamic>> vehicles;

  VehicleSearchDelegate(this.vehicles);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }

  @override
Widget buildSuggestions(BuildContext context) {
  final List<Map<String, dynamic>> suggestedVehicles = query.isEmpty
      ? vehicles
      : vehicles
          .where((vehicle) =>
              vehicle['name'].toLowerCase().contains(query.toLowerCase()))
          .toList();

  return ListView.builder(
    itemCount: suggestedVehicles.length,
    itemBuilder: (context, index) {
      return ListTile(
        title: Text('${suggestedVehicles[index]['name']}'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ShowVehicle(
                vehicle: suggestedVehicles[index],
              ),
            ),
          );
        },
      );
    },
  );
}

}
