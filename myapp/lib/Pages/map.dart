import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:routing_client_dart/routing_client_dart.dart';

class MapPage extends StatelessWidget {
  MapPage({super.key});

  final MapController _mapcontroller = MapController();

  final LatLng initialPoint = const LatLng(27.717245, 85.323959);
  final List<Marker> _markers = [
    const Marker(
    width: 80.0,
    height: 80.0,
    point: LatLng(27.717245, 85.323959),
    child: Icon(
      Icons.location_on,
      color: Colors.red,
      size: 50,
    ),
  )
  ];

  List<LngLat> waypoints = [
      LngLat(lng: 13.388860, lat: 52.517037),
      LngLat(lng: 13.397634, lat: 52.529407),
      LngLat(lng: 13.428555, lat: 52.523219),
    ];
    final manager = OSRMManager();

    Future<Road> getTrip() async {
      final road =  await manager.getTrip(
      waypoints: waypoints,
      roundTrip:false,
      source: SourceGeoPointOption.first,
      destination: DestinationGeoPointOption.last,
      geometries: Geometries.polyline,
      steps: true,
    );
    return road;
    }

     Future<Road> road = getTrip();

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: _mapcontroller,
      options: MapOptions(
        initialCenter: initialPoint,
        initialZoom: 14,
        maxZoom: 18,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.app',
          // tileBounds: LatLngBounds(LatLng(27.823258, 85.170916), LatLng(27.564915, 85.584R407)),
        ),
        MarkerLayer(markers: _markers),
        PolylineLayer(polylines: 
        [
          Polyline(
            points: [
              LatLng(27.717245, 85.170916),
              LatLng(27.564915, 85.323959),
              LatLng(27.717245, 85.584407), 
            ],
            color: Colors.red,
        ),],
        ),
        
        RichAttributionWidget(
          attributions: [
            TextSourceAttribution(
              'OpenStreetMap contributors',
              onTap: () =>
                  launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
            ),
          ],
        ),
      ],
    );
  }
}
