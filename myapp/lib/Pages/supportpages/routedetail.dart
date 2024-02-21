import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:latlong2/latlong.dart';
import 'package:myapp/Pages/components/constants.dart';
import 'package:myapp/Pages/supportpages/mapRoute.dart';

class RouteDetail extends StatefulWidget {
  final String routeID;

  const RouteDetail({Key? key, required this.routeID}) : super(key: key);

  @override
  State<RouteDetail> createState() => _RouteDetailState();
}

class _RouteDetailState extends State<RouteDetail> {
  Map<String, dynamic> routeData = {
    'name': '',
    'start': '',
    'end': '',
    'stops_list': [],
    'coordinates': []
  };


  bool isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchRouteAndStopsData();
  }

  Future<void> fetchRouteAndStopsData() async {
    try {
    final response = await http.get(
      Uri.parse('http://localhost:5000/routes/${widget.routeID}'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final Map<String, dynamic> routes = data as Map<String, dynamic>;

      if (mounted) {
        setState(() {
          routeData['name'] = routes['routeName'];
          routeData['start'] = routes['startStop'];
          routeData['end'] = routes['endStop'];
          routeData['stops_list'] = List<String>.from(routes['stopsData']);

          // Extract and store coordinates in [(lat, long)] format
          routeData['coordinates'] = List<Map<String, double>>.from(
            routes['latlongData'].map((coord) => {
              'lat': coord['lat'] as double,
              'long': coord['long'] as double,
            }),
          );

          // print(routeData['coordinates']);

          isLoading = false;
        });
      }
    } else {
      print('Error fetching route data: ${response.body}');
    }
  } catch (e) {
    print('Error fetching route data: $e');
  } finally {
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }
  }






  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              title: Text(
                '${routeData['name']}',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: ktextcolor,
                ),
              ),
            ),
            body: Container(
              padding: const EdgeInsets.all(16.0),
              child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 16.0),
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: kDefaultIconLightColor,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Starting: ${routeData['start']}',
                                style: TextStyle(
                                    fontSize: 16, color: kDefaultIconDarkColor),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                'Ending: ${routeData['end']}',
                                style: TextStyle(
                                    fontSize: 16, color: kDefaultIconDarkColor),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        const Text(
                          'Stops:',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Expanded(
                          child: ListView.builder(
                            itemCount: routeData['stops_list'].length,
                            itemBuilder: (context, index) {
                              return Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      color: kDefaultIconLightColor,
                                    ),
                                    child: Center(
                                      child: Padding(
                                        padding: EdgeInsets.only(top: 4.0),
                                        child: Text(
                                          '${routeData['stops_list'][index]}',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: kDefaultIconDarkColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ));
                            },
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MapRoute(
                                    
                                    routedetails: routeData),
                              ),
                            );
                          },
                          child: const Text('View in Map'),
                        ),
                      ],
                    ),
            ),
          );
  }
}
