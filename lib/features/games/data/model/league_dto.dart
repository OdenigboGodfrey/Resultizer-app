import 'dart:convert';

class LeagueDTO {
  final int id;
  final String name;
  final String logo;
  final String country;
  final String flag;

  LeagueDTO(
      {required this.id,
      required this.name,
      required this.logo,
      required this.country,
      required this.flag});

  factory LeagueDTO.fromJson(Map<String, dynamic> json) {
    try {
      var league = json['league'];
      var country = json['country'];
      return LeagueDTO(
          id: league['id'],
          name: league['name'],
          logo: league['logo'],
          country: country['name'],
          flag: country['flag']);
    } catch (exception) {
      try {
        return LeagueDTO(
            id: json['id'],
            name: json['name'],
            logo: json['logo'],
            country: json['country'],
            flag: json['flag']);
      } catch (exception) {rethrow;}
    }
  }

  String toJson() {
    return jsonEncode({
      "id": id,
      "name": name,
      "logo": logo,
      "country": country,
      "flag": flag,
    });
  }
}
