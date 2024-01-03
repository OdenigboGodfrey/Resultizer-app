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

// League games
class LeagueGamesLoaded extends SoccerStates {
  final List<dynamic> leagues;

  LeagueGamesLoaded(this.leagues);
}

class LeagueGamesLoadFailure extends SoccerStates {
  final String message;

  LeagueGamesLoadFailure(this.message);
}

class LeagueGamesLoading extends SoccerStates {}

// Team Games
class TeamGamesLoaded extends SoccerStates {
  final List<dynamic> leagues;

  TeamGamesLoaded(this.leagues);
}

class TeamGamesLoadFailure extends SoccerStates {
  final String message;

  TeamGamesLoadFailure(this.message);
}

class TeamGamesLoading extends SoccerStates {}



class TeamStatsLoading extends SoccerStates {}

class TeamStatsLoaded extends SoccerStates {
  final dynamic data;
  TeamStatsLoaded({required this.data});
}
class TeamStatsLoadingFailure extends SoccerStates {
  final String message;

  TeamStatsLoadingFailure(this.message);
}
