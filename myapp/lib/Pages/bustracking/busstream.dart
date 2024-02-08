import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myapp/Pages/bustracking/driverbt.dart';

class MapWidget extends StatefulWidget {
  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  late StreamSubscription<Map<String, double>> _locationSubscription;

  @override
  void initState() {
    super.initState();

    Driver driver = Driver();
    
    _locationSubscription =
        driver.locationStream.listen((locationData) {
          double latitude = locationData['latitude']!;
          double longitude = locationData['longitude']!;
          print('Driver Location - Latitude: $latitude, Longitude: $longitude');
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
      body: const Center(
        child: Text('Map Content'),
      ),
    );
  }
}
