import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/Pages/admin_components/VehicleEditPage.dart';

class BusView extends StatefulWidget {
  const BusView({super.key});

  @override
  State<BusView> createState() => _BusViewState();
}

class _BusViewState extends State<BusView> {
  List<Map<String, dynamic>> vehicles = [];
  bool isDataLoaded = false;

  @override
  void initState() {
    super.initState();
    fetchRoutes();
  }

  void fetchRoutes() async {
    try {
      final response =
          await http.get(Uri.parse('http://localhost:5000/vehicles'));

      if (mounted) {
        if (response.statusCode == 200) {
          final responseData = json.decode(response.body);
          setState(() {
            vehicles = List<Map<String, dynamic>>.from(responseData['vehicles']);
            isDataLoaded = true;
          });
        } else {
          throw Exception('Failed to load routes');
        }
      }
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
    );
    fetchRoutes();
  }
void onVehicleAdded() {
    fetchRoutes();
  }
  @override
  Widget build(BuildContext context) {
    return isDataLoaded
        ? Scaffold(
            appBar: AppBar(title: Text('Vehicles')),
            body: Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: vehicles.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(vehicles[index]['name'] + ' - '  + vehicles[index]['route']),
                        trailing: ElevatedButton(
                          onPressed: () {
                            navigateToVehicleEditPage(vehicles[index]);
                          },
                          child: Text('Edit'),
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
                                  builder: (context) => VehicleAdd(onVehicleAdded: onVehicleAdded,)));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                        child: const Text(
                          "Add a vehicle",
                        )),
                  )
                ],
              ),
            ),
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}
