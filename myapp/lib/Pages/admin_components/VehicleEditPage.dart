import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VehicleEditPage extends StatefulWidget {
  final String vehicleId;
  final String vehicleName;

  const VehicleEditPage({required this.vehicleId, required this.vehicleName});

  @override
  State<VehicleEditPage> createState() => _VehicleEditPageState();
}

class _VehicleEditPageState extends State<VehicleEditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Vehicle')),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Editing ${widget.vehicleName}',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class VehicleAdd extends StatefulWidget {
  const VehicleAdd({super.key});

  @override
  State<VehicleAdd> createState() => _VehicleAddState();
}

class _VehicleAddState extends State<VehicleAdd> {
  final TextEditingController bidController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController directionController = TextEditingController();
  final TextEditingController routeController = TextEditingController();

  handleAdd(String bid, String name, String type, String direction,
      String route) async {
    try {
      if (name.isNotEmpty ||
          bid.isNotEmpty ||
          type.isNotEmpty ||
          direction.isNotEmpty ||
          route.isNotEmpty) {
        var newVehicle = {
          "bid": bid,
          "name": name,
          "type": type,
          "direction": direction,
          "route": route,
        };

        var response = await http.post(
          Uri.parse('http://localhost:5000/addVehicle'),
          body: json.encode(newVehicle),
          headers: {"Content-Type": "application/json"},
        );

        if (response.statusCode == 422) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(jsonDecode(response.body)['error'])),
          );
        } else if (response.statusCode == 201) {
          print('vehicle added successfully');
          // print(response.body);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(jsonDecode(response.body)["message"])),
          );

          // Navigator.pop(context);
        } else {
          print('here');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(response.body)),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please fill all the fields')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Vehicle'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextFormField(
              controller: bidController,
              decoration: const InputDecoration(labelText: 'Bid'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: typeController,
              decoration: const InputDecoration(labelText: 'Type'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: directionController,
              decoration: const InputDecoration(labelText: 'Direction'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: routeController,
              decoration: const InputDecoration(labelText: 'Route'),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                final String bid = bidController.text;
                final String name = nameController.text;
                final String type = typeController.text;
                final String direction = directionController.text;
                final String route = routeController.text;

                handleAdd(bid, name, type, direction, route);
              },
              child: const Text('Add Vehicle'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    bidController.dispose();
    nameController.dispose();
    typeController.dispose();
    directionController.dispose();
    routeController.dispose();
    super.dispose();
  }
}
