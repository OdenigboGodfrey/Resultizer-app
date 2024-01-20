import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:resultizer_merged/core/utils/app_constants.dart';
import 'package:resultizer_merged/features/home/data/models/league_event_dto.dart';
import 'package:resultizer_merged/features/home/domain/use_cases/competition_fixtures_usecase.dart';
import 'package:resultizer_merged/features/home/domain/use_cases/day_fixtures_usecase.dart';
import 'package:resultizer_merged/features/home/domain/use_cases/team_fixtures_usecase.dart';
import 'package:resultizer_merged/features/home/domain/use_cases/team_stats_usecase.dart';
import 'package:resultizer_merged/features/home/presentation/cubit/soccer_state.dart';
import 'package:intl/src/intl/date_format.dart';
import 'package:resultizer_merged/features/notification/data/datasource/notification_datasource.dart';

class SoccerCubit extends Cubit<SoccerStates> {
  SoccerCubit(
      this.dayFixturesUseCase,
      this.teamFixturesUseCase,
      this.competitionFixturesUseCase,
      this.teamStatsUseCase,
      this.pastFixturesUseCase)
      : super(SoccerInitial()) {
        firebaseNotificationDataSource = FirebaseNotificationDataSource();
      }

  final DayFixturesUseCase dayFixturesUseCase;
  final TeamFixturesUseCase teamFixturesUseCase;
  final CompetitionFixturesUseCase competitionFixturesUseCase;
  final TeamStatsUseCase teamStatsUseCase;
  final PastFixturesUseCase pastFixturesUseCase;

  List day = [];
  int selected = 0;
  //List<SoccerFixture> dayFixtures = [];
  List<LeagueEventDTO> dayFixtures = [];
  bool hasRunForDayFixtures = false;
  List<LeagueEventDTO> teamFixtures = [];
  List<LeagueEventDTO> competitionFixtures = [];
  Map<String, List<String>> teamsForm = {};
  Map<String, Map<String, List<dynamic>>> teamsStats = {};
  List<Map<String, List<int>>> teamsStatsMap = [];

  late FirebaseNotificationDataSource firebaseNotificationDataSource;
  
  void getDaysOfNext7Days() {
    if (day.isNotEmpty) return;
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

  

  Future<List<LeagueEventDTO>> getUpcomingFixtures(String date) async {
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

  Future<List<LeagueEventDTO>> getFixturesByDate(String date) async {
    dayFixtures = [];
    emit(SoccerLeagueGamesLoading());
    final fixtures = await pastFixturesUseCase(date);
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

  refreshList(String date, {bool onlyFutureGames = true} ) {
    dayFixtures = [];
    hasRunForDayFixtures = false;
    emit(SoccerLeagueGamesLoading());
    if (onlyFutureGames) {
      getUpcomingFixtures(date);
    } else {
      getFixturesByDate(date);
    }
    
  }

  
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

  
  Future<List<LeagueEventDTO>> getFixturesByCompetition(
      int competitionId) async {
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

  

  Future<Map<String, Map<String, List<dynamic>>>> fetchTeamStatistics(
      int homeTeamId, int awayTeamId, int leagueId) async {
    teamsForm = {};
    teamsStats = {};
    teamsStatsMap = [];

    var result = await _getTeamsStatistic(homeTeamId, awayTeamId, leagueId);
    var home = result['home'];
    var away = result['away'];

    if (home.isNotEmpty) {
      /** Build team form value */
      teamsForm = {
        'Form': [
          home['form']
              .toString()
              .split('')
              .reversed
              .take(10)
              .toList()
              .reversed
              .join(),
        ]
      };

      /** Build Games Played value */

      teamsStats['Games Played'] = {
        'data': [home['fixtures']['played']['total']]
      };
      // teamsStats.add(teamsStats)

      /** Build wins value */
      teamsStats['Wins'] = {
        'data': [home['fixtures']['wins']['total']]
      };

      /** Build draws value */
      teamsStats['Draws'] = {
        "data": [home['fixtures']['draws']['total']]
      };

      /** Build loss value */
      teamsStats['Loses'] = {
        "data": [home['fixtures']['loses']['total']]
      };

      /** Build goals for value */
      teamsStats['Goals For'] = {
        "data": [home['goals']['for']['total']['total']]
      };

      /** Build goals against value */
      teamsStats['Goals Against'] = {
        "data": [home['goals']['against']['total']['total']]
      };

      /** Build goals for (avg) value */
      teamsStats['Goals For (avg)'] = {
        "data": [double.parse(home['goals']['for']['average']['total'])]
      };

      /** Build goals against (avg) value */
      teamsStats['Goals Against (avg)'] = {
        "data": [double.parse(home['goals']['against']['average']['total'])]
      };

      /** Build clean sheet value */
      teamsStats['Clean Sheet'] = {
        "data": [(home['clean_sheet']['total'])]
      };
    }

    if (away.isNotEmpty) {
      /** Build team form value */
      teamsForm['Form']!.add(away['form']
          .toString()
          .split('')
          .reversed
          .take(10)
          .toList()
          .reversed
          .join());

      /** Build Games Played value */
      teamsStats['Games Played']!['data']!
          .add(away['fixtures']['played']['total']);

      /** Build wind value */
      teamsStats['Wins']!['data']!.add(away['fixtures']['wins']['total']);

      /** Build draws value */
      teamsStats['Draws']!['data']!.addAll([away['fixtures']['wins']['total']]);
      teamsStats['Draws']!['inverseColourType'] = [true];

      /** Build loss value */
      teamsStats['Loses']!['data']!
          .addAll([away['fixtures']['loses']['total']]);
      // inverse colour type means having a higher value at comparison would result in red colour text not green
      // e.g higher total wins = green, higher total loses = red
      teamsStats['Loses']!['inverseColourType'] = [true];

      /** Build goals for value */
      teamsStats['Goals For']!['data']!
          .addAll([away['goals']['for']['total']['total']]);

      /** Build goals against value */
      teamsStats['Goals Against']!['data']!
          .addAll([away['goals']['against']['total']['total']]);
      teamsStats['Goals Against']!['inverseColourType'] = [true];

      /** Build goals for (avg) value */
      teamsStats['Goals For (avg)']!['data']!
          .addAll([double.parse(away['goals']['for']['average']['total'])]);

      /** Build goals against (avg) value */
      teamsStats['Goals Against (avg)']!['data']!
          .addAll([double.parse(away['goals']['against']['average']['total'])]);
      teamsStats['Goals Against (avg)']!['inverseColourType'] = [true];

      /** Build clean sheet value */
      teamsStats['Clean Sheet']!['data']!
          .addAll([(away['clean_sheet']['total'])]);
    }

    if (teamsStats.isEmpty) {
      emit(TeamStatsLoadingFailure('No statistics data loaded'));
    } else {
      emit(TeamStatsLoaded(data: teamsStats));
    }

    print('teamsStats');
    print(teamsStats);
    return teamsStats;
  }

  Future<Map<String, dynamic>> _getTeamsStatistic(
      int homeTeamId, int awayTeamId, int leagueId) async {
    Map<String, dynamic> teamStats = {'home': {}, 'away': {}};
    emit(TeamStatsLoading());
    // get home team stats
    (await teamStatsUseCase(TeamStatsParam(homeTeamId, leagueId))).fold((left) {
      emit(TeamStatsLoadingFailure(left.message));
    }, (right) {
      if (right != null) {
        teamStats['home'] = right;
        // emit(TeamStatsLoaded(data: right));
      } else {
        emit(TeamStatsLoadingFailure("No competition matches found."));
      }
    });
    (await teamStatsUseCase(TeamStatsParam(awayTeamId, leagueId))).fold((left) {
      emit(TeamStatsLoadingFailure(left.message));
    }, (right) {
      if (right != null) {
        teamStats['away'] = right;
        // emit(TeamStatsLoaded(data: right));
      } else {
        emit(TeamStatsLoadingFailure("No competition matches found."));
      }
    });
    return teamStats;
  }
}
