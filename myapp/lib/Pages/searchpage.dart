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
  final SearchController startLocationController = SearchController();
  final SearchController destinationLocationController = SearchController();
  bool isLoading = false;
  bool hasSearched = false;
  Map<String, dynamic> gdata = {};

  @override
  void dispose() {
    startLocationController.dispose();
    destinationLocationController.dispose();
    super.dispose();
  }

  Future<void> handleSearch(
      String startingLocation, String destinationLocation) async {
    setState(() {
      isLoading = true;
      hasSearched = true;
    });
    try {
      final search = {
        "source": startingLocation,
        "destination": destinationLocation,
      };

      final response = await http.post(
        Uri.parse('http://localhost:5000/search'),
        body: json.encode(search),
        headers: {"Content-Type": "application/json"},
      );
      setState(() {
        isLoading = false;
      });
      if (response.statusCode == 200) {
        setState(() {
          gdata = jsonDecode(response.body);
        });
      } else {
        print(jsonDecode(response.body)['message']);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget buildSearchResults() {
    if (isLoading) {
      return const Column(children: [
        SizedBox(
          height: 30,
        ),
        Center(child: CircularProgressIndicator())
      ]);
    } else if (hasSearched &&
        gdata.isNotEmpty &&
        gdata['message'] == "Matching routes found") {
      return Expanded(
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
              for (var routeData in gdata['data']) _buildRouteItem(routeData),
            ],
          ),
        ),
      );
    } else if (hasSearched) {
      return const Center(child: Text('No matching routes found.'));
    } else {
      return Container();
    }
  }

  Widget _buildRouteItem(dynamic routeData) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: ListTile(
        title: Text('Route: ${routeData['route']}',
            style: TextStyle(fontWeight: FontWeight.bold, color: ktextcolor)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Rate: Rs. ${routeData['rate']}',
              style: const TextStyle(color: Colors.black),
            ),
            Text(
              'Bus: ${routeData['bus']}',
              style: const TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SearchBarApp(controller: startLocationController),
            SearchBarApp(controller: destinationLocationController),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                final String startLocation = startLocationController.text;
                final String destinationLocation =
                    destinationLocationController.text;
                handleSearch(startLocation, destinationLocation);
              },
              style: ElevatedButton.styleFrom(backgroundColor: ktextcolor),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
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
            buildSearchResults(),
          ],
        ),
      ),
    );
  }
}
