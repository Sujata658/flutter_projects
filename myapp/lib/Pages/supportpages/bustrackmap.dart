import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class BusTrackerMap extends StatefulWidget {
  final LatLng position;

  BusTrackerMap({super.key, required this.position});

  @override
  State<BusTrackerMap> createState() => _BusTrackerMapState();
}

class _BusTrackerMapState extends State<BusTrackerMap> {
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: widget.position,
        initialZoom: 13.0,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
        ),
        MarkerLayer(
          markers: [
            Marker(
              width: 80.0,
              height: 80.0,
              point: widget.position,
               child: Icon(
                Icons.directions_bus,
                color: Colors.red,
                size: 40.0,
               )
            ),
          ],
        ),
      ],
    );
  }
}