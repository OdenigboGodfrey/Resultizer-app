import 'dart:convert';

class TeamListItemDTO {
  final int id;
  final String name;
  final String logo;
  final String country;
  final String code;

  TeamListItemDTO({required this.id, required this.name, required this.logo, required this.country, required this.code});

  
  factory TeamListItemDTO.fromJson(Map<String, dynamic> json) {
    try {
      var team = json['team'];
      return TeamListItemDTO(
          id: team['id'],
          name: team['name'],
          logo: team['logo'],
          country: team['country'],
          code: team['code'],
        );
    }
    catch(exception) {
      try {
        return TeamListItemDTO(
          id: json['id'],
          name: json['name'],
          logo: json['logo'],
          country: json['country'],
          code: json['code'],
        );
      } catch(exception) {rethrow;}
    }
  }

  String toJson() {
    return jsonEncode({
        "id": id,
        "name": name,
        "logo": logo,
        "country": country,
        "code": code,
    });
  }
}
