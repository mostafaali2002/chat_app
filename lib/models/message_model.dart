class Message {
  final String message;

  Message({required this.message});

  factory Message.fromJson(jsondata) {
    return Message(message: jsondata["message"]);
  }
}
