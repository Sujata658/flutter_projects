import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VehicleEditPage extends StatefulWidget {
  final Map<String, dynamic> vehicle;

  const VehicleEditPage({required this.vehicle});

  @override
  State<VehicleEditPage> createState() => _VehicleEditPageState();
}

class _VehicleEditPageState extends State<VehicleEditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Editing ${widget.vehicle['name']}',)),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              initialValue: widget.vehicle['bid'],
              decoration: const InputDecoration(labelText: 'Vehicle id'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              initialValue: widget.vehicle['name'],
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              initialValue: widget.vehicle['type'],
              decoration: const InputDecoration(labelText: 'Type'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              initialValue: widget.vehicle['direction'],
              decoration: const InputDecoration(labelText: 'Direction'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              initialValue: widget.vehicle['route'],
              decoration: const InputDecoration(labelText: 'Route'),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                
              },
              child: const Text('Edit Vehicle'),
            ),
            
          ],
        ),
      ),

    );
  }
}

class VehicleAdd extends StatefulWidget {
    final VoidCallback onVehicleAdded;
  const VehicleAdd({Key? key, required this.onVehicleAdded});

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
        } else if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Vehicle added successfully')),
          );
          widget.onVehicleAdded();
          Navigator.pop(context);
        } else { 
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('An error occurred: ${response.body}')),
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
              decoration: const InputDecoration(labelText: 'Vehicle id'),
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

class VehicleShowPage extends StatelessWidget {
  final Map<String, dynamic> vehicle;
  const VehicleShowPage({super.key, required Map<String, dynamic> this.vehicle});

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Vehicle: ${vehicle['name']}'),
    ),
    body: Container(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          ListTile(
            title: Text('Vehicle id'),
            subtitle: Text('${vehicle['bid']}'),
          ),
          ListTile(
            title: Text('Name'),
            subtitle: Text('${vehicle['name']}'),
          ),
          ListTile(
            title: Text('Type'),
            subtitle: Text('${vehicle['type']}'),
          ),
          ListTile(
            title: Text('Direction'),
            subtitle: Text('${vehicle['direction']}'),
          ),
          ListTile(
            title: Text('Route'),
            subtitle: Text('${vehicle['route']}'),
          ),
          Center(child: ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => VehicleEditPage(vehicle: vehicle),));
          
          }, child: Text('Edit')),)
        ],
      ),
    ),
  );
}

}