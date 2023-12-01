abstract class LeagueStates {}

class LeagueInitial extends LeagueStates {}
class LeagueLoaded extends LeagueStates {
  final List<dynamic> leagues;

  LeagueLoaded(this.leagues);
}

class LeagueLoadFailure extends LeagueStates {
  final String message;

  LeagueLoadFailure(this.message);
}

class LeagueLoading extends LeagueStates {}

