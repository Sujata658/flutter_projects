import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class MapPage extends StatelessWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
      ),
      body: Container(
        child: MapboxMap(
          onMapCreated: (controller) {
            // You can use the controller to interact with the map
          },
          initialCameraPosition: const CameraPosition(
            target: LatLng(52.376316, 4.897801),
            zoom: 15.0,
          ),
        ),
      ),
    );
  }
}
