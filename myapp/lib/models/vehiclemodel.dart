class VehicleModel {
  late String bid;
  late String name;
  // late String number;
  late String type;
  late String direction;
  late String route;

  VehicleModel({
    required this.bid,
    required this.name,
    // required this.number,
    required this.type,
    required this.direction,
    required this.route,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
      bid: json['bid'],
      name: json['name'],
      // number: json['number'],
      type: json['type'],
      direction: json['direction'] ?? "", // Assuming direction can be null
      route: json['route'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bid': bid,
      'name': name,
      // 'number': number,
      'type': type,
      'direction': direction,
      'route': route,
    };
  }
}
