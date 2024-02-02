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
  List<String> vehicleNames = [];
  List<String> vehicleIds = [];

  @override
  void initState() {
    super.initState();
    fetchRoutes();
  }

  void fetchRoutes() async {
    final response = await http.get(Uri.parse('http://localhost:5000/vehicleslist'));

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      setState(() {
        vehicleNames = List<String>.from(responseData['vehicleNames']);
        vehicleIds = List<String>.from(responseData['vehicleIds']);
      });
    } else {
      throw Exception('Failed to load routes');
    }
  }

  void navigateToVehicleEditPage(String vehicleId, String vehicleName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VehicleEditPage(vehicleId: vehicleId, vehicleName: vehicleName),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Buses')),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Buses', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              itemCount: vehicleNames.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(vehicleNames[index]),
                  trailing: ElevatedButton(
                    onPressed: () {
                      navigateToVehicleEditPage(vehicleIds[index], vehicleNames[index]);
                    },
                    child: Text('Edit'),
                  ),
                );
              },
            ),
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => VehicleAdd()));
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text(
                    "Add a vehicle",
                  )
                  ),
            )
          ],
        ),
      ),
    );
  }
}

