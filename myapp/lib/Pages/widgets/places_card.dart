import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/Pages/components/constants.dart';
import 'package:myapp/Pages/supportpages/routesList.dart';

class PlacesCard extends StatefulWidget {
  final Map<String, dynamic> product;
  final Function(dynamic)? onDataFetched;

  PlacesCard({Key? key, required this.product, this.onDataFetched})
      : super(key: key);

  @override
  State<PlacesCard> createState() => _PlacesCardState();
}

class _PlacesCardState extends State<PlacesCard> {
  late List<String> routeNames = [];
  late List<String> routeIds = [];

  Future<void> fetchData() async {
  try {
    final response = await http.get(Uri.parse('http://localhost:5000/BusesListByVehicleId/${widget.product['api']}'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final routeData = data['data'];

      setState(() {
        routeNames = List<String>.from(routeData['routeNames']);
        routeIds = List<String>.from(routeData['routeId']);
        // print('Route Names: $routeNames');
        // print('Route IDs: $routeIds');
      });
    } else {
      throw Exception('Failed to load data');
    }
  } catch (e) {
    print('Error fetching data: $e');
  }
}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () async {
          await fetchData();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RouteList(
                routeNames: routeNames,
                routeIds: routeIds,
                vehicleName: widget.product['name'],
              ),
            ),
          );
        },
        child: Container(
          width: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: klightcolor,
            boxShadow: [
              BoxShadow(
                spreadRadius: 2,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                widget.product['image'] as String,
                height: 100,
              ),
              SizedBox(height: 10),
              Text(
                widget.product['name'] as String,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: ktextcolor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
