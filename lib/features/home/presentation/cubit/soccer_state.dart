abstract class SoccerStates {}

class SoccerInitial extends SoccerStates {}
class SoccerLeagueGamessLoaded extends SoccerStates {
  final List<dynamic> leagues;

  SoccerLeagueGamessLoaded(this.leagues);
}

class SoccerLeagueGamesLoadFailure extends SoccerStates {
  final String message;

  SoccerLeagueGamesLoadFailure(this.message);
}

class SoccerLeagueGamesLoading extends SoccerStates {}

