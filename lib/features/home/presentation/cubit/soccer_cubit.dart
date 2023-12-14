import 'package:bloc/bloc.dart';
import 'package:resultizer_merged/core/utils/app_constants.dart';
import 'package:resultizer_merged/features/home/data/models/league_event_dto.dart';
import 'package:resultizer_merged/features/home/domain/use_cases/competition_fixtures_usecase.dart';
import 'package:resultizer_merged/features/home/domain/use_cases/day_fixtures_usecase.dart';
import 'package:resultizer_merged/features/home/domain/use_cases/team_fixtures_usecase.dart';
import 'package:resultizer_merged/features/home/presentation/cubit/soccer_state.dart';
import 'package:intl/src/intl/date_format.dart';


class SoccerCubit extends Cubit<SoccerStates> {
  SoccerCubit(this.dayFixturesUseCase, this.teamFixturesUseCase, this.competitionFixturesUseCase): super(SoccerInitial());

  final DayFixturesUseCase dayFixturesUseCase;
  final TeamFixturesUseCase teamFixturesUseCase;
  final CompetitionFixturesUseCase competitionFixturesUseCase;
  
  List day = [];
  void getDaysOfNext7Days() {
    var tempDay = [];
    // Get the current date.
    DateTime now = DateTime.now();

    // Create an array to store the next 7 days.
    // Loop over the next 7 days and add them to the array.
    for (int i = 0; i < 7; i++) {
      var futureTime = now.add(Duration(days: i));
      tempDay.add({
        'day': DateFormat('EEE').format(futureTime),
        'date': DateFormat('dd').format(futureTime),
        'dateTime': futureTime
      });
    }
    day = tempDay;
  }

  //List<SoccerFixture> dayFixtures = [];
  List<LeagueEventDTO> dayFixtures = [];
  bool hasRunForDayFixtures = false;
  
  Future<List<LeagueEventDTO>> getFixtures(String date) async {
    dayFixtures = [];
    emit(SoccerLeagueGamesLoading());
    final fixtures = await dayFixturesUseCase(date);
    List<LeagueEventDTO> filteredFixtures = [];
    fixtures.fold(
      (left) => emit(SoccerLeagueGamesLoadFailure(left.message)),
      (right) {
        AppConstants.leaguesFixtures.forEach((key, value) {
          value.fixtures.clear();
        });
        for (dynamic fixture in right) {
          filteredFixtures.add(fixture);
          dayFixtures = filteredFixtures;
        }
        emit(SoccerLeagueGamessLoaded(filteredFixtures));
      },
    );
    hasRunForDayFixtures = true;
    return filteredFixtures;
  }

  refreshList(String date) {
    dayFixtures = [];
    hasRunForDayFixtures = false;
    emit(SoccerLeagueGamesLoading());
    getFixtures(date);
  }

  List<LeagueEventDTO> teamFixtures = [];
  Future<List<LeagueEventDTO>> getFixturesByTeam(int teamId) async {
    teamFixtures = [];
    final result = await teamFixturesUseCase(teamId);
    result.fold((left) {
      emit(TeamGamesLoadFailure(left.message));
    }, (right) {
      if (right.isNotEmpty) {
        teamFixtures = right;
        emit(TeamGamesLoaded(right));
      } else {
        emit(TeamGamesLoadFailure("No team matches found."));
      }
    });
    return teamFixtures;
  }

  List<LeagueEventDTO> competitionFixtures = [];
  Future<List<LeagueEventDTO>> getFixturesByCompetition(int competitionId) async {
    competitionFixtures = [];
    final result = await competitionFixturesUseCase(competitionId);
    result.fold((left) {
      emit(LeagueGamesLoadFailure(left.message));
    }, (right) {
      if (right.isNotEmpty) {
        competitionFixtures = right;
        emit(LeagueGamesLoaded(right));
      } else {
        emit(LeagueGamesLoadFailure("No competition matches found."));
      }
      
    });
    return competitionFixtures;
  }
}