import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:latlong2/latlong.dart';
import 'package:myapp/Pages/bustracking/driverbt.dart';
import 'package:url_launcher/url_launcher.dart';

class MapWidget extends StatefulWidget {
  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  late StreamSubscription<Map<String, double>> _locationSubscription;
  LatLng driverLocation =
      LatLng(0, 0); // Initial location, you can set it to your default location

  @override
  void initState() {
    super.initState();

    Driver driver = Driver();

    _locationSubscription = driver.locationStream.listen((locationData) {
      double latitude = locationData['latitude']!;
      double longitude = locationData['longitude']!;
      print('Driver Location - Latitude: $latitude, Longitude: $longitude');

      setState(() {
        driverLocation = LatLng(latitude, longitude);
      });
    });

    driver.startSendingLocation();
  }

  @override
  void dispose() {
    _locationSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Driver Map'),
      ),
      body: FlutterMap(
        options: MapOptions(
          initialCenter:
              LatLng(27.2568, 53.3966),
          initialZoom: 13,
        ),
        children: [
         TileLayer(
              urlTemplate:
                  'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              tileProvider: CancellableNetworkTileProvider(),
           
         ),
          MarkerLayer(markers: [
            Marker(
              width: 80.0,
              height: 80.0,
              point:
                  driverLocation,
              child: Icon(
                Icons.directions_bus,
                color: Colors.blue,
                size: 40.0,
              ),
            ),
          ])
        ],
      ),
    );
  }
}