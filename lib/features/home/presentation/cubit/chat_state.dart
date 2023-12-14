
abstract class ChatStates {}

class ChatInitial extends ChatStates {}
class ChatLoadFailure extends ChatStates {
  final String message;

  ChatLoadFailure(this.message);
}

class ChatLoading extends ChatStates {}
class ChatReceived extends ChatStates {
  final dynamic data;
  ChatReceived(this.data);
}

class ChatSent extends ChatStates {
  final String message;
  ChatSent(this.message);
}

class ChatSendFail extends ChatStates {
  final String message;
  ChatSendFail(this.message);
}