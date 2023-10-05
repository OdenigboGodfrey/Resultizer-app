import 'dart:convert';

class OddsModel {
  final int id;
  final String name;
  final List<OddValue> odds;

  OddsModel({
    required this.id,
    required this.name,
    required this.odds,
  });

  factory OddsModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> oddsList = json['values'] ?? [];
    List<OddValue> betValues = oddsList
        .map((value) => OddValue.fromJson(value))
        .toList();

    return OddsModel(
      id: json['id'],
      name: json['name'],
      odds: betValues,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'odds': odds,
    };
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}

class OddValue {
  final String value;
  final String odd;
  final dynamic handicap;
  final dynamic main;
  final bool suspended;

  OddValue({
    required this.value,
    required this.odd,
    required this.handicap,
    required this.main,
    required this.suspended,
  });

  factory OddValue.fromJson(Map<String, dynamic> json) {
    return OddValue(
      value: json['value'],
      odd: json['odd'],
      handicap: json['handicap'],
      main: json['main'],
      suspended: json['suspended'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'value': value,
      'odd': odd,
      'handicap': handicap,
      'main': main,
      'suspended': suspended,
    };
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }

}
