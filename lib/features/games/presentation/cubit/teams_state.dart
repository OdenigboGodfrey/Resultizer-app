abstract class TeamsStates {}

class TeamsInitial extends TeamsStates {}
class TeamsLoaded extends TeamsStates {
  final List<dynamic> teams;

  TeamsLoaded(this.teams);
}

class TeamsLoadFailure extends TeamsStates {
  final String message;

  TeamsLoadFailure(this.message);
}

class TeamsLoading extends TeamsStates {}

