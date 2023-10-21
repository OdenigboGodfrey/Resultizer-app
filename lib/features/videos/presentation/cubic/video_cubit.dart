import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resultizer_merged/core/usecase/usecase.dart';
import 'package:resultizer_merged/features/videos/data/model/scorebat_model_dto.dart';
import 'package:resultizer_merged/features/videos/domain/usecase/highlights_by_competiton.dart';
import 'package:resultizer_merged/features/videos/domain/usecase/highlights_by_team.dart';
import 'package:resultizer_merged/features/videos/domain/usecase/list_competitons.dart';
import 'package:resultizer_merged/features/videos/domain/usecase/list_teams.dart';
import 'package:resultizer_merged/features/videos/domain/usecase/recent_feeds_usecase.dart';
import 'package:resultizer_merged/features/videos/presentation/cubic/video_state.dart';

class ScorebatCubit extends Cubit<ScorebatStates> {
  ScorebatCubit(this.recentFeedsUseCase, this.highlightByCompetitionUseCase, this.highlightByTeamUseCase, this.listTeamsUseCase, this.listCompetitionUseCase): super(RecentFeedsInitial());

  final RecentFeedsUseCase recentFeedsUseCase;
  final HighlightByCompetitionUseCase highlightByCompetitionUseCase;
  final HighlightByTeamUseCase highlightByTeamUseCase;
  final ListTeamsUseCase listTeamsUseCase;
  final ListCompetitionUseCase listCompetitionUseCase;
  
  List<ScorebatVideoModel> recentFeeds = [];
  List<ScorebatVideoModel> competitonHighlight = [];
  List<ScorebatVideoModel> teamHighlight = [];

  List<Map> competitons = [];
  List<Map> teams = [];
  
  Future<List<ScorebatVideoModel>> getRecentFeeds() async {
    recentFeeds = [];
    emit(RecentFeedsLoading());
    final feeds = await recentFeedsUseCase(NoParams());
    feeds.fold(
      (left) { 
        emit(RecentFeedsLoadFailure(left.message));
        },
      (right) {
        recentFeeds = right;
        emit(RecentFeedsLoaded(recentFeeds));
      },
    );
    return recentFeeds;
  }

  Future<List<ScorebatVideoModel>> getAllRecentFeeds() async {
    recentFeeds = [];
    emit(RecentFeedsLoading());
    final feeds = await recentFeedsUseCase(NoParams());
    feeds.fold(
      (left) { 
        emit(RecentFeedsLoadFailure(left.message));
        },
      (right) {
        recentFeeds = right;
        emit(RecentFeedsLoaded(recentFeeds));
      },
    );
    return recentFeeds;
  }

  Future<List<ScorebatVideoModel>> getHighlightsByCompetition(String competition) async {
    competitonHighlight = [];
    emit(CompetitonHighlightInitial());
    final feeds = await  highlightByCompetitionUseCase(competition);
    feeds.fold(
      (left) { 
        emit(CompetitonHighlightFailure(left.message));
        },
      (right) {
        competitonHighlight = right;
        emit(CompetitonHighlightLoaded(competitonHighlight));
      },
    );
    return competitonHighlight;
  }

  Future<List<ScorebatVideoModel>> getHighlightsByTeam(String team) async {
    teamHighlight = [];
    emit(CompetitonHighlightInitial());
    final feeds = await  highlightByTeamUseCase(team);
    feeds.fold(
      (left) { 
        emit(CompetitonHighlightFailure(left.message));
        },
      (right) {
        teamHighlight = right;
        emit(CompetitonHighlightLoaded(teamHighlight));
      },
    );
    return teamHighlight;
  }

  Future<List<Map>> getTeams() async {
    teams = [];
    emit(TeamHighlightLoading());
    final feeds = await listTeamsUseCase(NoParams());
    feeds.fold(
      (left) { 
        emit(TeamHighlightFailure(left.message));
        },
      (right) {
        teams = right;
        emit(TeamHighlightLoaded(teams));
      },
    );
    return teams;
  }

  Future<List<Map>> getCompetitions() async {
    competitons = [];
    emit(TeamHighlightLoading());
    final feeds = await listCompetitionUseCase(NoParams());
    feeds.fold(
      (left) { 
        emit(TeamHighlightFailure(left.message));
        },
      (right) {
        competitons = right;
        print('competitons');
        print(competitons);
        emit(TeamHighlightLoaded(competitons));
      },
    );
    return competitons;
  }
}