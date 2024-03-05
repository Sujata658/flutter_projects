import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  List<LatLng> decodedRoutePoints = [];
  bool isLoading = true;
  late Position currentLocation;
  List<String> routeNames = [];

  @override
  void initState() {
    super.initState();
  }
  
@override
void dispose() {
  super.dispose();
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map Page'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Routes List',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            for (String routeName in routeNames)
              ListTile(
                title: Text(routeName),
                onTap: () {
                  print('Selected route: $routeName');
                },
              ),
          ],
        ),
      ),
      body: Column(
              children: [
                Expanded(
                  child: FlutterMap(
                    options: const MapOptions(
                      initialCenter: LatLng(27.72, 85.31),
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
                            color: Colors.blue,
                          ),
                        ],
                      ),
                      const MarkerLayer(markers: [
                        Marker(
                          width: 80.0,
                          height: 80.0,
                          point: LatLng(27.72, 85.31),
                          child: Icon(
                            Icons.location_on,
                            color: Colors.blue,
                            size: 40.0,
                          ),
                        ),
                      ]),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
