import 'package:baato_api/models/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:baato_api/baato_api.dart';
import 'package:myapp/Pages/components/constants.dart';


class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  List<LatLng> decodedRoutePoints = [];
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


    findRoutes() async {
      var points = [];
      points.add("27.717844,85.3248188");
      points.add("27.727266,85.317497");
      points.add("27.6876224,85.33827");


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
      body: decodedRoutePoints == []
          ? const CircularProgressIndicator()
          : Column(
              children: [
                Expanded(
                  child: FlutterMap(
                    options: const MapOptions(
                      initialCenter: LatLng(27.717245, 85.323959),
                      initialZoom: 13.0,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.example.app',
                      ),
                     
                      PolylineLayer(
                        polylines: [
                          Polyline(
                            points: decodedRoutePoints,
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