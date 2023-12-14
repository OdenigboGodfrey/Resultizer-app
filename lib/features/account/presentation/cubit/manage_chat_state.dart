import 'package:resultizer_merged/features/auth/data/models/user_model.dart';

abstract class ManageChatStates {}

class ManageChatInitial extends ManageChatStates {}

class CountingChatInitial extends ManageChatStates {}
class CountingChatLoaded extends ManageChatStates {
  final int count;

  CountingChatLoaded(this.count);
}

class CountingChatFailure extends ManageChatStates {
  final String message;

  CountingChatFailure(this.message);
}

class GetChatMetaFailure extends ManageChatStates {
  final String message;

  GetChatMetaFailure(this.message);
}

class GetChatMetaLoaded extends ManageChatStates {
  final String message;

  GetChatMetaLoaded(this.message);
}

// class ManageChatLoading extends ManageChatStates {}

// class ManageChatUpdateFailed extends ManageChatStates {}
// class ManageChatUpdateLoading extends ManageChatStates {}
// class ManageChatUpdateSuccessful extends ManageChatStates {}

