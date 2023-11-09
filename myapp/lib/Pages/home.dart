import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController startLocationController = TextEditingController();
  TextEditingController destinationLocationController = TextEditingController();

  @override
  void dispose() {
    startLocationController.dispose();
    destinationLocationController.dispose();
    super.dispose();
  }

  Future<void> handleSearch(String startingLocation, String destinationLocation,
      BuildContext context) async {
    try {
      var search = {
        "source": startingLocation,
        "destination": destinationLocation,
      };

      var response = await http.post(
        Uri.parse('http://localhost:5000/search'),
        body: json.encode(search),
        headers: {"Content-Type": "application/json"},
      );
      var data = jsonDecode(response.body);
      print(data);

      if (response.statusCode == 400) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['error'])),
        );
      } else if (response.statusCode == 200) {
        // print(data[0]);
        print("I am here");
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data['message']),
          ),
        );
      }

      // Navigator.pushNamed(context, '/search');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomePage'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: startLocationController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Starting Location',
              ),
            ),
            const SizedBox(height: 16), // added SizedBox for spacing
            TextField(
              controller: destinationLocationController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Destination Location',
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  final String startLocation = startLocationController.text;
                  final String destinationLocation =
                      destinationLocationController.text;
                  handleSearch(startLocation, destinationLocation, context);
                },
                child: const Text('Search')),
          ],
        ),
      ),
    );
  }
}
