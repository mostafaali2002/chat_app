class Message {
  final String message;
  final String id;

  Message({required this.id, required this.message});

  factory Message.fromJson(jsondata) {
    return Message(message: jsondata["message"], id: jsondata["id"]);
  }
}
