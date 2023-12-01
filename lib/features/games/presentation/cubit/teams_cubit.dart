import 'package:bloc/bloc.dart';
import 'package:resultizer_merged/core/usecase/usecase.dart';
import 'package:resultizer_merged/features/games/data/model/team_list_item_dto.dart';
import 'package:resultizer_merged/features/games/domain/usecase/teams_usercase.dart';
import 'package:resultizer_merged/features/games/presentation/cubit/teams_state.dart';


class TeamsCubit extends Cubit<TeamsStates> {
  TeamsCubit(this.teamsUseCase): super(TeamsInitial());

  final TeamsUseCase teamsUseCase;
  
  List<TeamListItemDTO> teamList = [];
  
  Future<List<TeamListItemDTO>> getTeams(int leagueId) async {
    teamList = [];
    print('widget.leagueEvent.leagueId cubit ${leagueId}');
    emit(TeamsLoading());
    final fixtures = await teamsUseCase(leagueId);
    fixtures.fold(
      (left) { 
        emit(TeamsLoadFailure(left.message));
        },
      (right) {
        teamList = right;
        emit(TeamsLoaded(teamList));
      },
    );
    return teamList;
  }
}