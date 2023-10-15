class PlayerModel {
  final int? id;
  final String? name;

  

  factory PlayerModel.fromJson(Map<String, dynamic> json) {
    return PlayerModel(
      id: json['id'],
      name: json['name'],
    );
  }

  PlayerModel({this.id, this.name});
}