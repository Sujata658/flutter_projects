import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:baato_api/baato_api.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/Pages/components/constants.dart';
import 'package:myapp/Pages/supportpages/routedetail.dart';

import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';

class RouteData {
  final List<String> coordinates;
  final List<String> stopsNames;

  RouteData(this.coordinates, this.stopsNames);
}

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
  List<List<LatLng>> dark_decodedPolylines = [];
  List<List<LatLng>> grey_decodedPolylines = [];
  List<LatLng> change_points = [];
  List<LatLng> stops = [];
  List<dynamic> stopNames = [];
  bool isfetched = false;

  var currentRouteData = {};

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
                                      '${currentRouteData['routeId']}',
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
                                          'Rate: Rs. ${currentRouteData['rate']}',
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        Text(
                                          'Bus: ${currentRouteData['bus']}',
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
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => RouteDetail(
                                                  routeData:
                                                      currentRouteData)));
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
                for (var i = 0; i < grey_decodedPolylines.length; i++)
                  Polyline(
                    points: grey_decodedPolylines[i],
                    strokeWidth: 5.0,
                    color: Colors.grey,
                  ),
                for (var i = 0; i < dark_decodedPolylines.length; i++)
                  Polyline(
                    points: dark_decodedPolylines[i],
                    strokeWidth: 5.0,
                    color: getRandomColor(),
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
                          content: Text(currentRouteData['stopsNames']
                              [stops.indexOf(point)]),
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

      late List<String> routeIds = [];
      late List<List<String>> dark_coordinates = [];
      late List<List<String>> grey_coordinates = [];

      if (widget.routedetails[initialchoice]['flag'] == 'direct') {
        routeIds.add(widget.routedetails[initialchoice]['routeId']);

        dark_coordinates.add(await getStopsCoordinates(
            widget.routedetails[initialchoice]['lat_long']));

        final res = await getSingleCoordinates(
            widget.routedetails[initialchoice]['routeId']);
        grey_coordinates.add(res.coordinates);

        currentRouteData['routeId'] = routeIds[0];
        currentRouteData['rate'] = widget.routedetails[initialchoice]['rate'];
        currentRouteData['bus'] = widget.routedetails[initialchoice]['flag'];
        currentRouteData['stops'] = res.coordinates;
        currentRouteData['stopsNames'] = res.stopsNames;

        stops = grey_coordinates[0]
            .map((coord) => LatLng(double.parse(coord.split(',')[0]),
                double.parse(coord.split(',')[1])))
            .toList();
        stopNames = res.stopsNames;
      } else {
        routeIds = widget.routedetails[initialchoice]["unique_routes"]
            .cast<String>()
            .toList();

        dark_coordinates = await processChangePoints(
            widget.routedetails[initialchoice]["stops_list"]
                .cast<String>()
                .toList(),
            widget.routedetails[initialchoice]["change_point"],
            routeIds,
            widget.routedetails[initialchoice]["routes"]
                .cast<String>()
                .toList(),
            widget.routedetails[initialchoice]["lat_long"].toList());

        print(routeIds);

        for (var routeId in routeIds) {
          final res = await getSingleCoordinates(routeId);

          List<String> temp = res.coordinates;

          grey_coordinates.add(temp);
        }
        currentRouteData['routeId'] = "${routeIds[0]}-->${routeIds[1]}";
        currentRouteData['rate'] = widget.routedetails[initialchoice]['rate'];
        currentRouteData['bus'] = widget.routedetails[initialchoice]['flag'];
        currentRouteData['stops'] = dark_coordinates;
        currentRouteData['stopsNames'] = widget.routedetails[initialchoice]
            ["stops_name"];
        currentRouteData['change_point'] = widget.routedetails[initialchoice]["change_point"];
      }

      List<String> dark_encodedPolyline = await baatoPolyline(dark_coordinates);

      List<String> grey_encodedPolyline = await baatoPolyline(grey_coordinates);

      setState(() {
        dark_decodedPolylines = decodePolyline(dark_encodedPolyline);
        grey_decodedPolylines = decodePolyline(grey_encodedPolyline);
        isfetched = true;
      });
    } catch (e) {
      print('Error in MapRoute page: $e');
      setState(() {
        isfetched = false;
      });
    }
  }

  List<List<LatLng>> decodePolyline(List<String> encoded) {
    List<List<LatLng>> pointsss = [];
    for (var i = 0; i < encoded.length; i++) {
      List<LatLng> points = <LatLng>[];
      int index = 0, len = encoded[i].length;
      int lat = 0, lng = 0;

      while (index < len) {
        int b, shift = 0, result = 0;
        do {
          b = encoded[i].codeUnitAt(index++) - 63;
          result |= (b & 0x1f) << shift;
          shift += 5;
        } while (b >= 0x20);
        int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
        lat += dlat;

        shift = 0;
        result = 0;
        do {
          b = encoded[i].codeUnitAt(index++) - 63;
          result |= (b & 0x1f) << shift;
          shift += 5;
        } while (b >= 0x20);
        int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
        lng += dlng;

        points.add(LatLng(lat / 1E5, lng / 1E5));
      }
      pointsss.add(points);
    }

    return pointsss;
  }

  Future<RouteData> getSingleCoordinates(String routeId) async {
    List<LatLng> fullRouteCoordinates = [];
    List<String> finalCoord = [];
    List<String> stopsNames = [];

    final res =
        await http.get(Uri.parse('http://localhost:5000/routes/$routeId'));

    if (res.statusCode == 200) {
      final routeData = jsonDecode(res.body);

      fullRouteCoordinates = (routeData['latlongData'] as List)
          .map((coord) => LatLng(coord['lat'], coord['long']))
          .toList();

      stopsNames = (routeData['stopsData'] as List).cast<String>();
    }

    finalCoord = fullRouteCoordinates
        .map((coord) => '${coord.latitude},${coord.longitude}')
        .toList();

    return RouteData(finalCoord, stopsNames);
  }

  Future<List<String>> getStopsCoordinates(List<dynamic> latlng) async {
    List<String> finalcoord = [];

    final res =
        (latlng).map((coord) => LatLng(coord['lat'], coord['long'])).toList();

    finalcoord =
        res.map((coord) => '${coord.latitude},${coord.longitude}').toList();

    return finalcoord;
  }

  Future<List<String>> baatoPolyline(List<List<String>> coordinates) async {
    List<String> encodedPolylines = [];

    for (var coord in coordinates) {
      String baatoAccessToken =
          "bpk.Y3F6J1D0KoXZRXyiAh8qCGGD43TSSX7AzuDU9lhpK00g";

      BaatoRoute baatoRoute = BaatoRoute.initialize(
        accessToken: baatoAccessToken,
        points: coord,
        mode: "car",
        alternatives: false,
        instructions: false,
      );

      final response = await baatoRoute.getRoutes();
      String encodedPolyline = response.data?[0].encodedPolyline ?? "";

      encodedPolylines.add(encodedPolyline);
    }

    return encodedPolylines;
  }

  Future<List<List<String>>> processChangePoints(
    List<String> stopsList,
    String changePoint,
    List<String> unique_routes,
    List<String> routes,
    List<dynamic> latlong,
  ) async {
    List<dynamic> tempList = [];
    List<dynamic> secondtempList = [];
    List<List<String>> stopsListss = [];

    // print(latlong[stopsList.indexOf(changePoint)]);

    secondtempList.add(latlong[stopsList.indexOf(changePoint)]);

    for (int i = 0; i < routes.length;) {
      if (routes[i] == unique_routes[0]) {
        tempList.add(latlong[i]);
        i++;
      } else if (routes[i] == unique_routes[1]) {
        secondtempList.add(latlong[i]);
        i++;
      }
    }


    if (tempList.length > 0) {
      stopsListss.add(await getStopsCoordinates(tempList));
      stopsListss.add(await getStopsCoordinates(secondtempList));
    } else
      stopsListss.add([]);

    print(stopsListss.length);
    return stopsListss;
  }

  Color getRandomColor() {
    Random random = Random();
    int colorIndex = random.nextInt(4);

    switch (colorIndex) {
      case 0:
        return Colors.red;
      case 1:
        return Colors.blue;
      case 2:
        return Colors.green;
      case 3:
        return Colors.yellow;
      default:
        return Colors.red;
    }
  }
}


// final res = await http.get(Uri.parse(
      //     "http://localhost:5000/routes/${widget.routedetails[initialchoice]['routeId']}"));
      // if (res.statusCode == 200) {
      //   final singleroute = jsonDecode(res.body);

      //   currentRouteData = singleroute;

      //   coordinates =
      //       (singleroute['lat_long'] as List)
      //           .map((coord) => {
      //                 'lat': coord['lat'].toDouble(),
      //                 'long': coord['long'].toDouble(),
      //               })
      //           .toList();

      //   List<String> points = coordinates
      //       .map((coord) => '${coord['lat']},${coord['long']}')
      //       .toList();

      //   stops = coordinates
      //       .map((coord) => LatLng(coord['lat'], coord['long']))
      //       .toList();

      //   stopNames = (singleroute['stopsData']);