abstract class RecentFeedsStates {}

class RecentFeedsInitial extends RecentFeedsStates {}
class RecentFeedsLoaded extends RecentFeedsStates {
  final List<dynamic> leagues;

  RecentFeedsLoaded(this.leagues);
}

class RecentFeedsLoadFailure extends RecentFeedsStates {
  final String message;

  RecentFeedsLoadFailure(this.message);
}

class RecentFeedsLoading extends RecentFeedsStates {}

