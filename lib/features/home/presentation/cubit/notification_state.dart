
abstract class NotificationStates {}

class NotificationInitial extends NotificationStates {}
class NotificationLoadFailure extends NotificationStates {
  final String message;

  NotificationLoadFailure(this.message);
}

class NotificationLoading extends NotificationStates {}
class NotificationReceived extends NotificationStates {
  final dynamic data;
  NotificationReceived(this.data);
}

class NotificationSent extends NotificationStates {
  final String message;
  NotificationSent(this.message);
}

class NotificationSendFail extends NotificationStates {
  final String message;
  NotificationSendFail(this.message);
}