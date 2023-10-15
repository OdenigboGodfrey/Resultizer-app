class AssistModel {
  final int? id;
  final String? name;

  

  factory AssistModel.fromJson(Map<String, dynamic> json) {
    return AssistModel(
      id: json['id'],
      name: json['name'],
    );
  }

  AssistModel({this.id, this.name});
}