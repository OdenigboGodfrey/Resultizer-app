abstract class LiveGamesStates {}

class LiveGamesInitial extends LiveGamesStates {}
class LiveGamesLoaded extends LiveGamesStates {
  final List<dynamic> leagues;

  LiveGamesLoaded(this.leagues);
}

class LiveGamesLoadFailure extends LiveGamesStates {
  final String message;

  LiveGamesLoadFailure(this.message);
}

class LiveGamesLoading extends LiveGamesStates {}

