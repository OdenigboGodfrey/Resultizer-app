class ChatDTO {
  // final image;
  final String name;
  final String message;
  String userId;
  DateTime dateTime = DateTime.now();

  ChatDTO({
    // this.image,
    required this.name,
    required this.message,
    this.userId = '',
  });

  dynamic toJson() {
    return {
      "name": name,
      "message": message,
      "userId": userId,
      "dateTime": dateTime.toString(),
    };
  }
}
