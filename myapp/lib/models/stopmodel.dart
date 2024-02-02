class StopModel {
  late double lat;
  late double long;
  late String name;

  StopModel({
    required this.lat,
    required this.long,
    required this.name,
  });

  factory StopModel.fromJson(Map<String, dynamic> json) {
    return StopModel(
      lat: json['lat'],
      long: json['long'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'long': long,
      'name': name,
    };
  }
}
