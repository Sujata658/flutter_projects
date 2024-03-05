import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:baato_api/baato_api.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/Pages/components/constants.dart';
import 'package:myapp/Pages/supportpages/routedetail.dart';

import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';

class MapRoute extends StatefulWidget {
  final List<Map<String, dynamic>> routedetails;

  const MapRoute({
    Key? key,
    required this.routedetails,
  }) : super(key: key);

  @override
  State<MapRoute> createState() => _MapRouteState();
}

class _MapRouteState extends State<MapRoute> {
  var initialchoice = 0;
  List<LatLng> decodedRoutePoints = [];
  List<LatLng> stops = [];
  List<dynamic> stopNames = [];
  bool isfetched = false;
  
  var currentRouteData ;

  @override
  void initState() {
    super.initState();
    findRoutes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlidingUpPanel(
        backdropEnabled: true,
        minHeight: 80,
        panel: Container(
          decoration: BoxDecoration(
            color: klightcolor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: ktextcolor,
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 80,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Choose Route",
                            style: TextStyle(
                              color: ktextcolor,
                              fontSize: 20,
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: ktextcolor,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                      width: 50,
                      child: isfetched
                          ? const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                            )
                          : Center(
                              child: CircularProgressIndicator(
                                color: ktextcolor,
                              ),
                            )),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: widget.routedetails.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          initialchoice = index;
                        });
                        findRoutes();
                      },
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: index == initialchoice
                                  ? ktextcolor
                                  : const Color.fromARGB(255, 160, 160, 160),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: ListTile(
                                    title: Text(
                                      '${widget.routedetails[index]['route']}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Rate: Rs. ${widget.routedetails[index]['rate']}',
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        Text(
                                          'Bus: ${widget.routedetails[index]['bus']}',
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                if (index == initialchoice && isfetched)
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => RouteDetail(routeData: currentRouteData)));
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Text(
                                        'View Details',
                                        style: TextStyle(
                                          color: ktextcolor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        body: FlutterMap(
          options: const MapOptions(
            initialCenter: LatLng(27.717245, 85.323959),
            initialZoom: 13.0,
            maxZoom: 18.0,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.app',
            ),
            PolylineLayer(
              polylines: [
                if (decodedRoutePoints.isNotEmpty)
                  Polyline(
                    points: decodedRoutePoints,
                    strokeWidth: 5.0,
                    color: Colors.blue,
                  ),
              ],
            ),
            MarkerLayer(
              markers: stops
                  .map(
                    (point) => Marker(
                      width: 80.0,
                      height: 80.0,
                      point: point,
                      child: JustTheTooltip(
                          content: Text(stopNames[stops.indexOf(point)]),
                          child: Icon(
                            Icons.directions_bus,
                            color: ktextcolor,
                            size: 20,
                          )),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> findRoutes() async {
    try {
      setState(() {
        isfetched = false;
      });

      final res = await http.get(Uri.parse(
          "http://localhost:5000/routes/${widget.routedetails[initialchoice]['routeId']}"));

      if (res.statusCode == 200) {
        final singleroute = jsonDecode(res.body);

        currentRouteData = singleroute;


      List<Map<String, dynamic>> coordinates =
          (singleroute['latlongData'] as List)
              .map((coord) => {
                    'lat': coord['lat'].toDouble(),
                    'long': coord['long'].toDouble(),
                  })
              .toList();

      List<String> points = coordinates
          .map((coord) => '${coord['lat']},${coord['long']}')
          .toList();

      stops = coordinates
          .map((coord) => LatLng(coord['lat'], coord['long']))
          .toList();

      stopNames = (singleroute['stopsData']);

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

       setState(() {
          decodedRoutePoints = decodePolyline(encodedPolyline);
          isfetched = true;
        });
      } else {
        throw Exception('Failed to fetch route data. Status code: ${res.statusCode}');
      }
    } catch (e) {
      print('Error in MapRoute page: $e');
      setState(() {
        isfetched = false;
      });
    }
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
