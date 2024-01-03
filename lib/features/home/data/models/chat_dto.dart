class ChatDTO {
  // final image;
  final String name;
  final String message;
  String userId;
  DateTime dateTime = DateTime.now();
  int fixtureId;

  ChatDTO({
    // this.image,
    required this.name,
    required this.message,
    this.userId = '',
    required this.fixtureId,
  });

  dynamic toJson() {
    return {
      "name": name,
      "message": message,
      "userId": userId,
      "dateTime": dateTime.toString(),
      "fixtureId": fixtureId,
    };
  }
}
