class FareModel {
  late String starting;
  late String ending;
  late double rate;
  late String bus;

  FareModel({
    required this.starting,
    required this.ending,
    required this.rate,
    required this.bus,
  });

  factory FareModel.fromJson(Map<String, dynamic> json) {
    return FareModel(
      starting: json['starting'],
      ending: json['ending'],
      rate: json['rate'].toDouble(),
      bus: json['bus'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'starting': starting,
      'ending': ending,
      'rate': rate,
      'bus': bus,
    };
  }
}
