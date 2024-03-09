import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:baato_api/baato_api.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/Pages/components/constants.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  List<LatLng> decodedRoutePoints = [];
  bool isFetched = true;
  Map<String, dynamic> fake = {};
  Map<String, List<String>> routeData = {};
  int selectedIndex = 0;
  var currentRouteData;

  @override
  void initState() {
    super.initState();
    getRoutes();
  }

  Future<void> getRoutes() async {
    try {
      final response =
          await http.get(Uri.parse('http://localhost:5000/routes'));

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final List<String> routeNames = List<String>.from(
          responseData['routes']
                  ?.map<String>((route) => route['name'].toString()) ??
              [],
        );
        final List<String> routeIds = List<String>.from(
          responseData['routes']
                  ?.map<String>((route) => route['id'].toString()) ??
              [],
        );
        final List<String> ids = List<String>.from(
          responseData['routes']
                  ?.map<String>((route) => route['_id'].toString()) ??
              [],
        );

        setState(() {
          routeData = {
            'routeNames': routeNames,
            'routeIds': routeIds,
            'ids': ids,
          };
        });
      } else {
        throw Exception('Failed to load routes');
      }
    } catch (e) {
      print('Error in MapPage: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return routeData.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Explore Routes'),
                  SizedBox(
                    width: 50,
                    child: isFetched
                        ? const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          )
                        : Center(
                            child: CircularProgressIndicator(
                              color: ktextcolor,
                            ),
                          ),
                  ),
                ],
              ),
            ),
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: ktextcolor,
                    ),
                    child: const Text(
                      'Routes List',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  for (int index = 0;
                      index < (routeData['routeNames']?.length ?? 0);
                      index++)
                    ListTile(
                      title: Text(routeData['routeNames']![index]),
                      onTap: () {
                        print(
                            'Selected RouteId: ${routeData['routeIds']?[index]}');
                        setState(() {
                          selectedIndex = index;
                        });
                        findRoutes();
                      },
                      selected: selectedIndex == index,
                    ),
                ],
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: FlutterMap(
                    options: const MapOptions(
                      initialCenter: LatLng(27.717245, 85.323959),
                      initialZoom: 13.0,
                      maxZoom: 18.0,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.example.app',
                      ),
                      PolylineLayer(
                        polylines: [
                          if (decodedRoutePoints.isNotEmpty)
                            Polyline(
                              points: decodedRoutePoints,
                              strokeWidth: 5.0,
                              color: Colors.blue,
                            ),
                        ],
                      ),
                      MarkerLayer(
                        markers: [
                          for (int i = 0; i < fake.length; i++)
                            Marker(
                              width: 80.0,
                              height: 80.0,
                              point: fake.isEmpty
                                  ? LatLng(27.717245, 85.323959)
                                  : LatLng(
                                      double.parse(fake['$i']?[0] ?? '27.717245'),
                                      double.parse(fake['$i']?[1] ?? '85.323959'),
                                    ),
                              child: const Icon(
                                Icons.location_on,
                                color: Colors.red,
                                size: 40.0,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }

  Future<void> findRoutes() async {
    try {
      setState(() {
        isFetched = false;
      });

      final response = await http.get(
        Uri.parse(
            "http://localhost:5000/routes/${routeData['routeIds']?[selectedIndex]}"),
      );

      if (response.statusCode == 200) {
        final singleRoute = jsonDecode(response.body);

        currentRouteData = singleRoute;

        final List<Map<String, dynamic>> coordinates =
            List<Map<String, dynamic>>.from(
          (singleRoute['latlongData'] as List).map(
            (coord) => {
              'lat': coord['lat'].toDouble(),
              'long': coord['long'].toDouble(),
            },
          ),
        );

        final List<String> points = coordinates
            .map((coord) => '${coord['lat']},${coord['long']}')
            .toList();

        coordinates.shuffle();

        const String baatoAccessToken =
            "bpk.Y3F6J1D0KoXZRXyiAh8qCGGD43TSSX7AzuDU9lhpK00g";

        final BaatoRoute baatoRoute = BaatoRoute.initialize(
          accessToken: baatoAccessToken,
          points: points,
          mode: "car",
          alternatives: false,
          instructions: false,
        );

        final baatoResponse = await baatoRoute.getRoutes();
        final String encodedPolyline =
            baatoResponse.data?[0].encodedPolyline ?? "";

        setState(() {
          fake = {
            for (int i = 0; i < min(5, coordinates.length); i++)
              i.toString(): [
                coordinates[i]['lat'].toString(),
                coordinates[i]['long'].toString(),
              ],
          };
          decodedRoutePoints = decodePolyline(encodedPolyline);
          isFetched = true;
        });
      } else {
        throw Exception(
            'Failed to fetch route data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in MapRoute page: $e');
      setState(() {
        isFetched = false;
      });
    }
  }

  List<LatLng> decodePolyline(String encoded) {
    List<LatLng> points = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      points.add(LatLng(lat / 1E5, lng / 1E5));
    }
    return points;
  }
}
