import 'package:resultizer_merged/features/games/data/model/league_dto.dart';
import 'package:resultizer_merged/features/games/data/model/team_list_item_dto.dart';
import 'package:resultizer_merged/features/home/data/models/league_event_dto.dart';
import 'package:resultizer_merged/features/home/data/models/premier_game_dto.dart';

abstract class FavouritesStates {}

class FavouritesInitial extends FavouritesStates {}
class FavouritesLeaguesLoaded extends FavouritesStates {
  final Map<String, LeagueDTO> leagues;

  FavouritesLeaguesLoaded(this.leagues);
}

class FavouritesLeaguesSaved extends FavouritesStates {
  final String message;

  FavouritesLeaguesSaved(this.message);
}

class FavouritesTeamsLoaded extends FavouritesStates {
  final Map<String, TeamListItemDTO> teams;

  FavouritesTeamsLoaded(this.teams);
}

class FavouritesLoadFailure extends FavouritesStates {
  final String message;

  FavouritesLoadFailure(this.message);
}

class FavouritesLoading extends FavouritesStates {}

class FavouriteTeamsSaved extends FavouritesStates {
  final String message;

  FavouriteTeamsSaved(this.message);
}

class FavouritesMatchSaved extends FavouritesStates {
  final String message;

  FavouritesMatchSaved(this.message);
}

class FavouritesMatchesLoaded extends FavouritesStates {
  final Map<String, LeagueEventDTO> matches;

  FavouritesMatchesLoaded(this.matches);
}
