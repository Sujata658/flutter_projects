import 'dart:async';

import 'package:geolocator/geolocator.dart';

class Driver {
  final StreamController<Map<String, double>> _locationStreamController =
      StreamController<Map<String, double>>();
  late Timer _locationTimer;

  Stream<Map<String, double>> get locationStream =>
      _locationStreamController.stream;

  void startSendingLocation() {
    _locationTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      // print(Geolocator.getCurrentPosition());
      Geolocator.getCurrentPosition().then((position) {
        double latitude = position.latitude;
        double longitude = position.longitude;
        _locationStreamController
            .add({'latitude': latitude, 'longitude': longitude});
      });
    });
  }

  void stopSendingLocation() {
    _locationTimer.cancel();
    _locationStreamController.close();
  }
}