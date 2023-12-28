import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/Pages/components/components.dart';
import 'package:myapp/Pages/components/constants.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController startLocationController = TextEditingController();
  TextEditingController destinationLocationController = TextEditingController();
  Map<String, dynamic> gdata = {};

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
      var ldata = jsonDecode(response.body);

      if (response.statusCode == 200) {

        setState(() {
          gdata = ldata;
        });
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomTextField(textField: TextField(
              controller: startLocationController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Starting Location',
              ),
            ),),
            
            const SizedBox(height: 16),
            CustomTextField(textField: TextField(
              controller: destinationLocationController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Destination Location',
              ),
            ),),
            
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  final String startLocation = startLocationController.text;
                  final String destinationLocation =
                      destinationLocationController.text;
                  handleSearch(startLocation, destinationLocation, context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ktextcolor,
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize
                      .min, 
                  children: [
                    Icon(Icons.search, color: Colors.white), 
                    SizedBox(width: 8.0), 
                    Text(
                      'Search',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (gdata.isNotEmpty && gdata['message'] == "Matching routes found")
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      const Text(
                        'Search Results:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      for (var routeData in gdata['data'])
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: ListTile(
                            title: Text('Route: ${routeData['route']}', style: TextStyle(fontWeight: FontWeight.bold, color: ktextcolor)),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Rate: Rs. ${routeData['rate']}', style: const TextStyle(color: Color.fromRGBO(0, 0, 0, 1)),),
                                Text('Bus: ${routeData['bus']}',style: const TextStyle(color: Colors.black),),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
