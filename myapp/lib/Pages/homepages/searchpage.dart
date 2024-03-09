import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:myapp/Pages/components/components.dart';
import 'package:myapp/Pages/components/constants.dart';
import 'package:myapp/Pages/supportpages/mapRoute.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final MySearchController startLocationController = MySearchController();
  final MySearchController destinationLocationController = MySearchController();

  bool isLoading = false;

  @override
  void dispose() {
    startLocationController.dispose();
    destinationLocationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SearchBarApp(
              controller: startLocationController,
              hintText: "Start Location",
            ),
            SearchBarApp(
              controller: destinationLocationController,
              hintText: "Destination Location",
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                final String startLocation = startLocationController.id;
                final String destinationLocation =
                    destinationLocationController.id;
                handleSearch(startLocation, destinationLocation);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ktextcolor,
              ),
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
            const SizedBox(height: 16.0),
            isLoading
                ? Container(
                    width: 24.0,
                    height: 24.0,
                    margin: const EdgeInsets.only(right: 8.0),
                    child: const CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  void handleSearch(String startLocation, String destinationLocation) async {
    setState(() {
      isLoading = true;
    });

    try {
      final search = {
        "source": startLocation,
        "destination": destinationLocation,
      };

      final searchRes = await http.post(
        Uri.parse('http://localhost:5000/search'),
        body: json.encode(search),
        headers: {"Content-Type": "application/json"},
      );

      if (searchRes.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(searchRes.body);

        if (responseData['message'] == 'Matching routes found') {
          List<Map<String, dynamic>> routesData =
              List<Map<String, dynamic>>.from(responseData['data']);

          if (routesData.isNotEmpty) {
            nextpage(routesData);
            return;
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('No matching routes found'),
              ),
            );
          }
        }
      }
    } catch (e) {
      print('Error in search page: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void nextpage(List<Map<String, dynamic>> routeData) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MapRoute(routedetails: routeData),
      ),
    );
  }
}
