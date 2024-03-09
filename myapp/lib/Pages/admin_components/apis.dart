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
      final List<String> ids = (responseData['routes'] as List<dynamic>?)
              ?.map<String>((route) => route['_id'].toString())
              .toList() ??
          [];

      return {'routeNames': routeNames, 'routeIds': routeIds, 'ids': ids};
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
        if (responseData is Map<String, dynamic>) {
          return responseData;
        } else {
          throw Exception('Invalid response format');
        }
      } else {
        throw Exception(
            'Failed to get single route. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error getting single route: $e');
      throw Exception('Error getting single route: $e');
    }
  }

  static Future<int> updateRoute(String Ids, String id, String routesName,
      String starting, String ending, List<String> stopIds) async {
    try {
      var updatedRoute = {
        "id": id,
        "name": routesName,
        "start": starting,
        "end": ending,
        "stops_list": stopIds,
      };

      var response = await http.put(
        Uri.parse('http://localhost:5000/route/$Ids'),
        body: json.encode(updatedRoute),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 422) {
        throw Exception(jsonDecode(response.body)['error']);
      } else if (response.statusCode == 200) {
        return response.statusCode;
      } else {
        throw Exception(response.body);
      }
    } catch (e) {
      throw Exception('Error updating route: $e');
    }
  }

  static Future<int> deleteRoute(String id) async {
    try {
      var response = await http.delete(Uri.parse('http://localhost:5000/route/$id'));

      if (response.statusCode == 200) {
        return response.statusCode;
      } else {
        throw Exception('Failed to delete route. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error deleting route: $e');
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
                  'Id': stop['_id'].toString(),
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

  static Future<int> addStop(String id,
      String lat, String lng, String name, BuildContext context) async {
    try {
      var newStop = {"id": id, "lat": lat, "long": lng, "name": name};

      var response = await http.post(
        Uri.parse('http://localhost:5000/addstop'),
        body: json.encode(newStop),
        headers: {"Content-Type": "application/json"},
      );
      return response.statusCode;

      
    } catch (e) {
      print('Error adding stop: $e');
      throw Exception('Error adding stop: $e');
    }
  }

  static Future<Map<String, dynamic>> getSingleStop(String id) async {
    try {
      final response =
          await http.get(Uri.parse('http://localhost:5000/stops/$id'));

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData is Map<String, dynamic>) {
          return responseData;
        } else {
          throw Exception('Invalid response format');
        }
      } else {
        throw Exception(
            'Failed to get single stop. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error getting single stop: $e');
      throw Exception('Error getting single stop: $e');
    }
  }

  static Future<int> updateStop(
      String Ids, String id, String lat, String lng, String name) async {
    try {
      var updatedStop = {"id": id, "lat": lat, "long": lng, "name": name};

      var response = await http.put(
        Uri.parse('http://localhost:5000/stop/$Ids'),
        body: json.encode(updatedStop),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 422) {
        throw Exception(jsonDecode(response.body)['error']);
      } else if (response.statusCode == 200) {
        return response.statusCode;
      } else {
        throw Exception(response.body);
      }
    } catch (e) {
      throw Exception('Error updating stop: $e');
    }
  }

  static Future<int> deleteStop(String id) async {
    try {
      var response = await http.delete(Uri.parse('http://localhost:5000/stop/$id'));

      if (response.statusCode == 200) {
        return response.statusCode;
      } else {
        throw Exception('Failed to delete stop. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error deleting stop: $e');
    }
  }

}

class VehicleApi {
  static Future<List<Map<String, dynamic>>> getVehicles() async {
    final response =
        await http.get(Uri.parse('http://localhost:5000/vehicles'));

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final List<dynamic> vehiclesData =
          responseData['Vehiclees']; // Corrected key

      List<Map<String, dynamic>> vehiclesList = vehiclesData.map((vehicle) {
        return {
          '_id': vehicle['_id'],
          'vid': vehicle['vid'],
          'name': vehicle['name'],
          'type': vehicle['type'],
        };
      }).toList();

      return vehiclesList;
    } else {
      throw Exception('Failed to load vehicles');
    }
  }
}
