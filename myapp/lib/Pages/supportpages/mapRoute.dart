import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:baato_api/baato_api.dart';

class MapRoute extends StatefulWidget {
  final Map<String, dynamic> routedetails;
  

  const MapRoute({
    Key? key,
    required this.routedetails,
  }) : super(key: key);

  @override
  State<MapRoute> createState() => _MapRouteState();
}

class _MapRouteState extends State<MapRoute> {
  List<LatLng> decodedRoutePoints = [];
  List<LatLng> stops = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    findRoutes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: FlutterMap(
                    options: MapOptions(
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
                              strokeWidth: 4.0,
                              color: Colors.blue,
                            ),
                        ],
                      ),
                      MarkerLayer(markers: [
                        for (var stop in widget.routedetails['coordinates'])
                          Marker(
                            width: 80.0,
                            height: 80.0,
                            point: LatLng(
                              stop['lat'],
                              stop['long'],
                            ),
                            child: const Icon(
                              Icons.location_on,
                              color: Colors.green,
                              size: 40.0,
                            ),
                          ),
                        Marker(
                          width: 80.0,
                          height: 80.0,
                          point: decodedRoutePoints.first,
                          child: const Icon(
                            Icons.location_on,
                            color: Colors.red,
                            size: 40.0,
                          ),
                        ),
                        Marker(
                          width: 80.0,
                          height: 80.0,
                          point: decodedRoutePoints.last,
                          child: const Icon(
                            Icons.location_on,
                            color: Colors.red,
                            size: 40.0,
                          ),
                        ),
                      ]),
                    ],
                  ),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: findRoutes,
                      child: const Text('Find Routes'),
                    ),
                  ],
                ),
              ],
            ),
    );
  }

  void findRoutes() async {
    List<Map<String, double>> coordinates =
        widget.routedetails['coordinates'].cast<Map<String, double>>();

    List<String> points = coordinates
        .map((coord) => '${coord['lat']},${coord['long']}')
        .toList();

    String baatoAccessToken =
        "bpk.Y3F6J1D0KoXZRXyiAh8qCGGD43TSSX7AzuDU9lhpK00g";

    BaatoRoute baatoRoute = BaatoRoute.initialize(
      accessToken: baatoAccessToken,
      points: points,
      mode: "car",
      alternatives: false,
      instructions: false,
    );
    final response = await baatoRoute.getRoutes();
    String encodedPolyline = response.data?[0].encodedPolyline ?? "";

    decodedRoutePoints = decodePolyline(encodedPolyline);

    setState(() {
      isLoading = false;
    });
  }

  List<LatLng> decodePolyline(String encoded) {
    List<LatLng> points = <LatLng>[];
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