import 'package:bloc/bloc.dart';
import 'package:get/get.dart';
import 'package:resultizer_merged/core/utils/app_global.dart';
import 'package:resultizer_merged/features/games/data/model/league_dto.dart';
import 'package:resultizer_merged/features/games/data/model/team_list_item_dto.dart';
import 'package:resultizer_merged/features/home/data/models/league_event_dto.dart';
import 'package:resultizer_merged/features/home/data/models/premier_game_dto.dart';
import 'package:resultizer_merged/features/home/domain/use_cases/favourite_league_usecase.dart';
import 'package:resultizer_merged/features/home/domain/use_cases/favourite_matches_usecase.dart';
import 'package:resultizer_merged/features/home/domain/use_cases/favourite_teams_usecase.dart';
import 'package:resultizer_merged/features/home/presentation/cubit/favourites_state.dart';

class FavouritesCubit extends Cubit<FavouritesStates> {
  // FavouritesCubit(): super(FavouritesInitial());

  final SetFavouriteTeamsUseCase setFavouriteTeamsUseCase;
  final GetFavouriteTeamsUseCase getFavouriteTeamsUseCase;
  final RemoveFavouriteTeamsUseCase removeFavouriteTeamsUseCase;

  final SetFavouriteLeagueUseCase setFavouriteLeagueUseCase;
  final GetFavouriteLeagueUseCase getFavouriteLeagueUseCase;
  final RemoveFavouriteLeagueUseCase removeFavouriteLeagueUseCase;

  final SetFavouriteMatchesUseCase setFavouriteMatchesUseCase;
  final GetFavouriteMatchesUseCase getFavouriteMatchesUseCase;
  final RemoveFavouriteMatchesUseCase removeFavouriteMatchesUseCase;

  Map<String, TeamListItemDTO> teams = {};

  FavouritesCubit({
    required this.setFavouriteTeamsUseCase,
    required this.getFavouriteTeamsUseCase,
    required this.setFavouriteLeagueUseCase,
    required this.getFavouriteLeagueUseCase,
    required this.removeFavouriteLeagueUseCase,
    required this.removeFavouriteTeamsUseCase,
    required this.setFavouriteMatchesUseCase,
    required this.getFavouriteMatchesUseCase,
    required this.removeFavouriteMatchesUseCase,
  }) : super(FavouritesInitial());

  Future<Map<String, TeamListItemDTO>> getTeams() async {
    teams.clear();
    String uid = GlobalDataSource.userData.id;
    emit(FavouritesLoading());
    final fixtures = await getFavouriteTeamsUseCase(uid);
    fixtures.fold(
      (left) {
        emit(FavouritesLoadFailure(left.message));
      },
      (right) {
        if (right.status) {
          right.data.forEach((key, value) {
            teams[key] = TeamListItemDTO.fromJson(value);
          });
          emit(FavouritesTeamsLoaded(teams));
        } else {
          emit(FavouritesLoadFailure(right.message));
        }
      },
    );
    return teams;
  }

  Map<String, LeagueDTO> leagues = {};

  Future<Map<String, LeagueDTO>> getLeagues() async {
    leagues.clear();
    String uid = GlobalDataSource.userData.id;
    emit(FavouritesLoading());
    final fixtures = await getFavouriteLeagueUseCase(uid);
    fixtures.fold(
      (left) {
        emit(FavouritesLoadFailure(left.message));
      },
      (right) {
        if (right.status) {
          right.data.forEach((key, value) {
            leagues[key] = LeagueDTO.fromJson(value);
          });
          emit(FavouritesLeaguesLoaded(leagues));
        } else {
          emit(FavouritesLoadFailure(right.message));
        }
      },
    );
    return leagues;
  }

  Future<Map<String, LeagueDTO>> saveLeagues(LeagueDTO item) async {
    String uid = GlobalDataSource.userData.id;
    emit(FavouritesLoading());
    final result = await setFavouriteLeagueUseCase(
        SetFavouriteLeagueParam(uid: uid, item: {item.id: item}));
    result.fold(
      (left) {
        // emit(FavouritesLoadFailure(left.message));
        throw Exception(left.message);
      },
      (right) {
        if (right) {
          emit(FavouritesLeaguesSaved('Action successful.'));
        } else {
          emit(FavouritesLoadFailure('Failed to save to favourites.'));
        }
      },
    );
    return leagues;
  }

  Future<Map<String, LeagueDTO>> saveTeam(TeamListItemDTO item) async {
    String uid = GlobalDataSource.userData.id;
    emit(FavouritesLoading());
    final result = await setFavouriteTeamsUseCase(
        SetFavouriteTeamsParam(uid: uid, item: {item.id: item}));
    result.fold(
      (left) {
        // emit(FavouritesLoadFailure(left.message));
        throw Exception(left.message);
      },
      (right) {
        if (right) {
          emit(FavouriteTeamsSaved('Action successful.'));
        } else {
          emit(FavouritesLoadFailure('Failed to save to favourite.'));
        }
      },
    );
    return leagues;
  }

  Future removeTeam(TeamListItemDTO item) async {
    String uid = GlobalDataSource.userData.id;
    emit(FavouritesLoading());
    final result = await removeFavouriteTeamsUseCase(
        RemoveFavouriteTeamsParam(uid: uid, teamId: item.id));
    result.fold(
      (left) {
        // emit(FavouritesLoadFailure(left.message));
        throw Exception(left.message);
      },
      (right) {
        if (right) {
          emit(FavouriteTeamsSaved('Removed from favourite.'));
        } else {
          emit(FavouritesLoadFailure('Failed to remove from favourites.'));
        }
      },
    );
  }

  Future removeLeague(LeagueDTO item) async {
    String uid = GlobalDataSource.userData.id;
    emit(FavouritesLoading());
    final result = await removeFavouriteLeagueUseCase(
        RemoveFavouriteLeagueParam(uid: uid, leagueId: item.id));
    result.fold(
      (left) {
        // emit(FavouritesLoadFailure(left.message));
        throw Exception(left.message);
      },
      (right) {
        if (right) {
          emit(FavouriteTeamsSaved('Removed from favourites.'));
        } else {
          emit(FavouritesLoadFailure('Failed to remove from favourites.'));
        }
      },
    );
  }

  Map<String, LeagueEventDTO> matches = {};
  Future<Map<String, LeagueEventDTO>> getMatches() async {
    matches.clear();
    if (GlobalDataSource.userData == null) return matches;
    String uid = GlobalDataSource.userData.id;
    emit(FavouritesLoading());
    final fixtures = await getFavouriteMatchesUseCase(uid);
    fixtures.fold(
      (left) {
        emit(FavouritesLoadFailure(left.message));
      },
      (right) {
        if (right.status) {
          right.data.forEach((key, value) {
            var leagueData = LeagueEventDTO.fromAppDbJson(value);
            List<PremierGameDTO> games = [];
            List<PremierGameDTO>? tmpGames =
                matches[leagueData.leagueId.toString()]?.games;
            if (tmpGames != null) games = tmpGames;

            if (matches.containsKey(leagueData.leagueId.toString())) {
              if (games.firstWhereOrNull((element) => element.fixtureId == leagueData.fixtureId) == null) {
                games.add(leagueData.games[0]);
                matches[leagueData.leagueId.toString()]?.games = games;
              }
              
            } else {
              matches[leagueData.leagueId.toString()] = leagueData;
            }
          });
          emit(FavouritesMatchesLoaded(matches));
        } else {
          emit(FavouritesLoadFailure(right.message));
        }
      },
    );
    return matches;
  }

  Future<Map<String, LeagueEventDTO>> saveMatch(LeagueEventDTO item) async {
    String uid = GlobalDataSource.userData.id;
    emit(FavouritesLoading());
    final result = await setFavouriteMatchesUseCase(
        SetFavouriteMatchesParam(uid: uid, item: {item.fixtureId: item}));
    result.fold(
      (left) {
        throw Exception(left.message);
      },
      (right) {
        if (right) {
          emit(FavouriteTeamsSaved('Action successful.'));
        } else {
          throw Exception('Failed to save to favourites.');
        }
      },
    );
    return matches;
  }

  Future removeMatch(LeagueEventDTO item) async {
    String uid = GlobalDataSource.userData.id;
    emit(FavouritesLoading());
    final result = await removeFavouriteMatchesUseCase(
        RemoveFavouriteMatchesParam(uid: uid, fixtureId: item.fixtureId));
    result.fold(
      (left) {
        // emit(FavouritesLoadFailure(left.message));
        throw Exception(left.message);
      },
      (right) {
        if (right) {
          emit(FavouriteTeamsSaved('Removed from favourites.'));
        } else {
          // emit(FavouritesLoadFailure('Failed to save'));
          throw Exception('Failed to remove from favourites');
        }
      },
    );
  }

  // Future initFn() {

  // }

  // refreshList(String date) {
  //   matches = [];
  //   emit(FavouritesLoading());
  //   getLiveGames();
  // }
}
