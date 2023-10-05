import 'package:bloc/bloc.dart';
import 'package:resultizer_merged/core/usecase/usecase.dart';
import 'package:resultizer_merged/core/utils/app_constants.dart';
import 'package:resultizer_merged/features/home/data/models/league_event_dto.dart';
import 'package:resultizer_merged/features/home/domain/use_cases/day_fixtures_usecase.dart';
import 'package:resultizer_merged/features/home/domain/use_cases/live_fixtures_usecase.dart';
import 'package:resultizer_merged/features/home/presentation/cubit/live_games_state.dart';
import 'package:resultizer_merged/features/home/presentation/cubit/soccer_state.dart';
import 'package:intl/src/intl/date_format.dart';


class LiveGamesCubit extends Cubit<LiveGamesStates> {
  LiveGamesCubit(this.liveGamesUseCase): super(LiveGamesInitial());

  final LiveGamesUseCase liveGamesUseCase;
  
  List<LeagueEventDTO> matches = [];
  
  Future<List<LeagueEventDTO>> getLiveGames() async {
    matches = [];
    emit(LiveGamesLoading());
    final fixtures = await liveGamesUseCase(NoParams());
    fixtures.fold(
      (left) { 
        print(left);
        print(left.message);
        emit(LiveGamesLoadFailure(left.message));
        },
      (right) {
        AppConstants.leaguesFixtures.forEach((key, value) {
          value.fixtures.clear();
        });
        for (dynamic fixture in right) {
          matches.add(fixture);
        }
        emit(LiveGamesLoaded(matches));
      },
    );
    return matches;
  }

  refreshList(String date) {
    matches = [];
    emit(LiveGamesLoading());
    getLiveGames();
  }
}