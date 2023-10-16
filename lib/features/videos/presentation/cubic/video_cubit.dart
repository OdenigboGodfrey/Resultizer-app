import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resultizer_merged/core/usecase/usecase.dart';
import 'package:resultizer_merged/features/videos/data/model/recent_feeds_dto.dart';
import 'package:resultizer_merged/features/videos/domain/usecase/recent_feeds_usecase.dart';
import 'package:resultizer_merged/features/videos/presentation/cubic/video_state.dart';

class RecentFeedsCubit extends Cubit<RecentFeedsStates> {
  RecentFeedsCubit(this.recentFeedsUseCase): super(RecentFeedsInitial());

  final RecentFeedsUseCase recentFeedsUseCase;
  
  List<RecentFeedsModel> recentFeeds = [];
  
  Future<List<RecentFeedsModel>> getRecentFeeds() async {
    recentFeeds = [];
    emit(RecentFeedsLoading());
    final feeds = await recentFeedsUseCase(NoParams());
    feeds.fold(
      (left) { 
        emit(RecentFeedsLoadFailure(left.message));
        },
      (right) {
        recentFeeds = right;
        emit(RecentFeedsLoaded(recentFeeds.sublist(0, 15)));
      },
    );
    return recentFeeds.sublist(0, 15);
  }

  Future<List<RecentFeedsModel>> getAllRecentFeeds() async {
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
}