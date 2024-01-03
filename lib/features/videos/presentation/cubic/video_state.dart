abstract class ScorebatStates {}

class RecentFeedsInitial extends ScorebatStates {}
class RecentFeedsLoaded extends ScorebatStates {
  final List<dynamic> leagues;

  RecentFeedsLoaded(this.leagues);
}

class RecentFeedsLoadFailure extends ScorebatStates {
  final String message;

  RecentFeedsLoadFailure(this.message);
}

class RecentFeedsLoading extends ScorebatStates {}


class CompetitonHighlightInitial extends ScorebatStates {}
class CompetitonHighlightLoaded extends ScorebatStates {
  final List<dynamic> data;

  CompetitonHighlightLoaded(this.data);
}

class CompetitonHighlightFailure extends ScorebatStates {
  final String message;

  CompetitonHighlightFailure(this.message);
}

class CompetitonHighlightLoading extends ScorebatStates {}


class TeamHighlightInitial extends ScorebatStates {}
class TeamHighlightLoaded extends ScorebatStates {
  final List<dynamic> data;

  TeamHighlightLoaded(this.data);
}

class TeamHighlightFailure extends ScorebatStates {
  final String message;

  TeamHighlightFailure(this.message);
}

class TeamHighlightLoading extends ScorebatStates {}

