import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RouteApi {
  static Future<Map<String, List<String>>> getRoutes() async {
    final response =
        await http.get(Uri.parse('http://localhost:5000/routeslist'));

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      // Check for null values before casting
      final List<String> routeNames =
          (responseData['routeNames'] as List<dynamic>?)?.cast<String>() ?? [];
      final List<String> routeIds =
          (responseData['routeIds'] as List<dynamic>?)?.cast<String>() ?? [];

      return {
        'routeNames': routeNames,
        'routeIds': routeIds,
      };
    } else {
      throw Exception('Failed to load routes');
    }
  }

  static Future<void> addRoute(String id,String routesName, String starting,
      String ending, List<String> stopIds) async {
    try {
      var newRoute = {
        "id": id,
        "name": routesName,
        "start": starting,
        "end": ending,
        "stops_list": stopIds,
      };

      var response = await http.post(
        Uri.parse('http://localhost:5000/addroute'),
        body: json.encode(newRoute),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 422) {
        throw Exception(jsonDecode(response.body)['error']);
      } else if (response.statusCode == 201) {
        print('Route added successfully');
      } else {
        throw Exception(response.body);
      }
    } catch (e) {
      print('Error adding route: $e');
    }
  }
}

class StopApi {
  static Future<List<Map<String, dynamic>>> getStops() async {
  final response = await http.get(Uri.parse('http://localhost:5000/stops'));

  if (response.statusCode == 200) {
    final responseData = json.decode(response.body);

    if (responseData.containsKey('stops')) {
      List<dynamic> stopsData = responseData['stops'];

      List<Map<String, dynamic>> stopsList = stopsData
          .map((stop) => {
                'id': stop['id'].toString(),
                'name': stop['name'],
                'lat': stop['lat'].toDouble(),
                'long': stop['long'].toDouble(),
              })
          .toList();

      return stopsList;
    } else {
      throw Exception('Invalid response format: "stops" key not found');
    }
  } else {
    throw Exception('Failed to load stops');
  }
}

  static Future<void> addStop(String lat, String lng, String name, BuildContext context) async {
    try {
      var newStop = {"lat": lat, "long": lng, "name": name};

      var response = await http.post(
        Uri.parse('http://localhost:5000/addstop'),
        body: json.encode(newStop),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 422) {
        throw Exception(jsonDecode(response.body)['error']);
      } else if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Stop added successfully'),
          ),
        );
      } else {
        throw Exception(response.body);
      }
    } catch (e) {
      print('Error adding stop: $e');
    }
  }
}

class BusApi {
  static Future<Map<String, List<String>>> getBus() async {
    final response =
        await http.get(Uri.parse('http://localhost:5000/vehicleslist'));

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return {
        'vehicleNames': List<String>.from(responseData['vehicleNames']),
      };
    } else {
      throw Exception('Failed to load stops');
    }
  }
}
