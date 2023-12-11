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
  var gdata = <Map<String, dynamic>>[];

  @override
  void dispose() {
    startLocationController.dispose();
    destinationLocationController.dispose();
    super.dispose();
  }

  Future<void> handleSearch(
      String startingLocation, String destinationLocation, BuildContext context) async {
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
      var ldata = jsonDecode(response.body);

      if (response.statusCode == 400) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(ldata['error'])),
        );
      } else if (response.statusCode == 200) {
        setState(() {
          gdata = List<Map<String, dynamic>>.from(ldata['data']);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(ldata['message']),
          ),
        );
      }
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
            const SizedBox(height: 16),
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
                final String destinationLocation = destinationLocationController.text;
                handleSearch(startLocation, destinationLocation, context);
              },
              child: const Text('Search'),
            ),
            if (gdata.isNotEmpty)
  Expanded(
    child: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        color: Colors.grey[200],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Search Results:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            for (var i = 0; i < gdata.length; i++)
              ListTile(
                title: Text('Route ${i + 1}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var stop in gdata[i]['stops'])
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text(
                          'Stop: ${stop['name']}, Fare: ${stop['fare']}, Distance: ${stop['distance']}, Time: ${stop['time']}',
                        ),
                      ),
                  ],
                ),
              ),
          ],
        ),
      ),
    ),
  ),

          ],
        ),
      ),
    );
  }
}
