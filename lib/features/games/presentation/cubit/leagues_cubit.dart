import 'package:bloc/bloc.dart';
import 'package:resultizer_merged/core/usecase/usecase.dart';
import 'package:resultizer_merged/core/utils/app_constants.dart';
import 'package:resultizer_merged/features/games/data/model/league_dto.dart';
import 'package:resultizer_merged/features/games/domain/usecase/leagues_usercase.dart';
import 'package:resultizer_merged/features/games/presentation/cubit/leagues_state.dart';
import 'package:resultizer_merged/features/home/data/models/league_event_dto.dart';
import 'package:resultizer_merged/features/home/domain/use_cases/live_fixtures_usecase.dart';
import 'package:resultizer_merged/features/home/presentation/cubit/live_games_state.dart';


class LeagueCubit extends Cubit<LeagueStates> {
  LeagueCubit(this.leagueUseCase): super(LeagueInitial());

  final LeagueUseCase leagueUseCase;
  
  List<LeagueDTO> leagues = [];
  
  Future<List<LeagueDTO>> getLeagues() async {
    leagues = [];
    emit(LeagueLoading());
    final fixtures = await leagueUseCase(NoParams());
    fixtures.fold(
      (left) { 
        emit(LeagueLoadFailure(left.message));
        },
      (right) {
        leagues = right;
        emit(LeagueLoaded(leagues));
      },
    );
    return leagues;
  }

  // refreshList(String date) {
  //   matches = [];
  //   emit(LeagueLoading());
  //   getLeagues();
  // }
}