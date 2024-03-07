import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RouteApi {
  static Future<Map<String, List<String>>> getRoutes() async {
    final response = await http.get(Uri.parse('http://localhost:5000/routes'));

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      final List<String> routeNames = (responseData['routes'] as List<dynamic>?)
              ?.map<String>((route) => route['name'].toString())
              .toList() ??
          [];
      final List<String> routeIds = (responseData['routes'] as List<dynamic>?)
              ?.map<String>((route) => route['id'].toString())
              .toList() ??
          [];

      return {
        'routeNames': routeNames,
        'routeIds': routeIds,
      };
    } else {
      throw Exception('Failed to load routes');
    }
  }

  static Future<void> addRoute(String id, String routesName, String starting,
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

  static Future<Map<String, dynamic>> getSingleRoute(String id) async {
    try {
      final response =
          await http.get(Uri.parse('http://localhost:5000/routes/$id'));

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return responseData;
      } else {
        throw Exception('Failed to get single route');
      }
    } catch (e) {
      print('Error getting single route: $e');
      throw Exception('Error getting single route: $e');
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


  static Future<void> addStop(
      String lat, String lng, String name, BuildContext context) async {
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
  static Future<List<Map<String, dynamic>>> getVehicles() async {
    final response =
        await http.get(Uri.parse('http://localhost:5000/vehicles'));

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final List<dynamic> vehiclesData = responseData['vehicles'];

      List<Map<String, dynamic>> vehiclesList = vehiclesData.map((vehicle) {
        return {
          '_id': vehicle['_id'],
          'bid': vehicle['bid'],
          'name': vehicle['name'],
          'type': vehicle['type'],
          'direction': vehicle['direction'],
          'route': vehicle['route'],
        };
      }).toList();

      return vehiclesList;
    } else {
      throw Exception('Failed to load vehicles');
    }
  }

  static Future<Map<String, List<String>>> getVehiclesList() async {
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
