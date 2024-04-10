import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/Pages/components/constants.dart';

class RouteList extends StatefulWidget {
  const RouteList(
      {Key? key,
      required this.routeNames,
      required this.routeIds,
      required this.vehicleName})
      : super(key: key);

  final List<String> routeNames;
  final List<String> routeIds;
  final String vehicleName;

  @override
  State<RouteList> createState() => _RouteListState();
}

class _RouteListState extends State<RouteList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.vehicleName),
      ),
      body: ListView.builder(
        itemCount: widget.routeNames.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 3,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AllDetailPage(
                      routeName: widget.routeNames[index],
                      routeId: widget.routeIds[index],
                    ),
                  ),
                );
              },
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.routeNames[index],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(Icons.arrow_forward),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class AllDetailPage extends StatefulWidget {
  final String routeName;
  final String routeId;

  const AllDetailPage(
      {Key? key, required this.routeName, required this.routeId})
      : super(key: key);

  @override
  State<AllDetailPage> createState() => _AllDetailPageState();
}

class _AllDetailPageState extends State<AllDetailPage> {
  late List<dynamic> stopsData = [];

  @override
  void initState() {
    super.initState();
    fetchDetails();
  }

  Future<void> fetchDetails() async {
    try {
      // print('Route ID: ${widget.routeId}');
      final response = await http
          .get(Uri.parse('http://localhost:5000/routes/${widget.routeId}'));

      // print('Response: ${response.body}');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          stopsData = data['stopsData'];
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.routeName),
      ),
      body: stopsData.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: stopsData.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 3,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    leading: CircleAvatar(
                      backgroundColor: ktextcolor,
                      child: Icon(Icons.location_on, color: Colors.white),
                    ),
                    title: Text(
                      stopsData[index],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('Stop ${index + 1}'),
                  ),
                );
              },
            ),
    );
  }
}
