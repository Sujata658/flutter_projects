import 'package:baato_api/models/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:baato_api/baato_api.dart';
import 'package:myapp/Pages/components/constants.dart';

class MapRoute extends StatefulWidget {
  final Map<String, dynamic> routedetails;
  final Map<String, Object> coordinates;

  const MapRoute({
    Key? key,
    required this.routedetails,
    required this.coordinates,
  }) : super(key: key);

  @override
  State<MapRoute> createState() => _MapRouteState();
}

class _MapRouteState extends State<MapRoute> {
  List<LatLng> decodedRoutePoints = [];
  List<LatLng> stops = [];

  get http => null;

  @override
  Widget build(BuildContext context) {
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

    stops = (widget.coordinates['stops'] as List<LatLng>?) ?? [];
    findRoutes() async {
      var points = [];
      var somerandom = [];

      (widget.coordinates['stops'] as List<LatLng>?)?.forEach((stop) {
        points.add('${stop.latitude},${stop.longitude}');
      });

      int third = points.length ~/ 3;
      for (int i = 0; i < third; i++) {
        somerandom.add(points[i]);
      }

      print(points);

      String baatoAccessToken =
          "bpk.Y3F6J1D0KoXZRXyiAh8qCGGD43TSSX7AzuDU9lhpK00g";

      BaatoRoute baatoRoute = BaatoRoute.initialize(
          accessToken: baatoAccessToken,
          points: points,
          mode: "car",
          alternatives: false,
          instructions: false);
      RouteResponse response = await baatoRoute.getRoutes();
      String encodedPolyline = response.data?[0].encodedPolyline ?? "";

      decodedRoutePoints = decodePolyline(encodedPolyline);
      setState(() {});
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
      ),
      body: decodedRoutePoints == []
          ? const CircularProgressIndicator()
          : Column(
              children: [
                Expanded(
                  child: FlutterMap(
                    options: MapOptions(
                      initialCenter: LatLng(27.717245, 85.323959),
                      initialZoom: 13.0,
                      maxZoom: 18.0
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.example.app',
                      ),
                      // MarkerLayer(
//   markers: [
//     for (var stop in stops)
//       Marker(
//         width: 80.0,
//         height: 80.0,
//         point: stop,
//         child: Container(
//           child: const Icon(
//             Icons.location_on,
//             color: Colors.red,
//           ),
//         ),
//       ),
//   ],
// ),

                      PolylineLayer(
                        polylines: [
                          Polyline(
                            points: stops,
                            strokeWidth: 4.0,
                            color: ktextcolor,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        findRoutes();
                      },
                      child: const Text('Find Routes'),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
