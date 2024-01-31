import 'dart:convert';
import 'package:http/http.dart' as http;

class RouteApi {
  static Future<Map<String, List<String>>> getRoutes() async {
    final response = await http.get(Uri.parse('http://localhost:5000/routeslist'));

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      // Check for null values before casting
      final List<String> routeNames = (responseData['routeNames'] as List<dynamic>?)?.cast<String>() ?? [];
      final List<String> routeIds = (responseData['routeIds'] as List<dynamic>?)?.cast<String>() ?? [];

      return {
        'routeNames': routeNames,
        'routeIds': routeIds,
      };
    } else {
      throw Exception('Failed to load routes');
    }
  }



  static Future<void> addRoute(String routesName, String starting,
      String ending, List<String> stopIds) async {
    try {
      var newRoute = {
        "name": routesName,
        "starting": starting,
        "ending": ending,
        "stops": stopIds,
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
  static Future<Map<String, List<String>>> getStops() async {
    final response =
        await http.get(Uri.parse('http://localhost:5000/stopslist'));

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return {
        'stopsName': List<String>.from(responseData['stopsName']),
      };
    } else {
      throw Exception('Failed to load stops');
    }
  }

  static Future<void> addStop(String lat, String lng, String name) async {
    try {
      var newStop = {"lat": lat, "long": lng, "name": name};

      var response = await http.post(
        Uri.parse('http://localhost:5000/addstop'),
        body: json.encode(newStop),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 422) {
        throw Exception(jsonDecode(response.body)['error']);
      } else if (response.statusCode == 201) {
        print('Stop added successfully');
      } else {
        throw Exception(response.body);
      }
    } catch (e) {
      print('Error adding stop: $e');
    }
  }
}
