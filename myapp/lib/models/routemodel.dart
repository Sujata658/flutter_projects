// class AppRoute {
//   final String name;
//   final String starting;
//   final String ending;
//   final List<String> stops;

//   AppRoute({required this.name, required this.starting, required this.ending, required this.stops});

//   factory AppRoute.fromJson(Map<String, dynamic> json) {
//     return AppRoute(
//       name: json['name'],
//       starting: json['starting']['_id'],
//       ending: json['ending']['_id'],
//       stops: List<String>.from(json['stops'].map((stop) => stop['_id'])),
//     );
//   }
// }


import 'package:mongo_dart/mongo_dart.dart';

class RouteModel {
  ObjectId? id;
  late String name;
  late ObjectId start;
  late ObjectId end;  
  late List<ObjectId> stops;

  RouteModel({
    this.id,
    required this.name,
    required this.start,
    required this.end,
    required this.stops,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'start': start, 
      'end': end,     
      'stops': stops,
    };
  }

  factory RouteModel.fromMap(Map<String, dynamic> map) {
    return RouteModel(
      id: map['id'],
      name: map['name'],
      start: map['start'], // Changed from 'starting' to 'start'
      end: map['end'],     // Changed from 'ending' to 'end'
      stops: List<ObjectId>.from(map['stops']),
    );
  }
}
