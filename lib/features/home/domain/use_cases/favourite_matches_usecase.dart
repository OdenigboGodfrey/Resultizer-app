import 'package:dartz/dartz.dart';
import 'package:resultizer_merged/core/dto/response_dto.dart';
import 'package:resultizer_merged/core/error/error_handler.dart';
import 'package:resultizer_merged/core/usecase/usecase.dart';
import 'package:resultizer_merged/features/games/data/model/team_list_item_dto.dart';
import 'package:resultizer_merged/features/home/data/models/league_event_dto.dart';
import 'package:resultizer_merged/features/home/data/models/premier_game_dto.dart';
import 'package:resultizer_merged/features/home/domain/repositories/favourite_repository.dart';

class SetFavouriteMatchesParam {
  final String uid;
   final Map<int, LeagueEventDTO> item;

  SetFavouriteMatchesParam({required this.uid, required this.item});
}

class RemoveFavouriteMatchesParam {
  final String uid;
   final int fixtureId;

  RemoveFavouriteMatchesParam({required this.uid, required this.fixtureId});
}

class SetFavouriteMatchesUseCase implements UseCase<bool, SetFavouriteMatchesParam> {
  final FavouriteRepository favouriteRepository;

  SetFavouriteMatchesUseCase({required this.favouriteRepository});
  
  @override
  Future<Either<Failure, bool>> call(SetFavouriteMatchesParam item) async {
    return await favouriteRepository.setFavouriteMatch(item.uid, item.item);
  }
}


class GetFavouriteMatchesUseCase implements UseCase<ResponseDTO<Map<dynamic, dynamic>>, String> {
  final FavouriteRepository favouriteRepository;

  GetFavouriteMatchesUseCase({required this.favouriteRepository});
  
  @override
  Future<Either<Failure, ResponseDTO<Map<dynamic, dynamic>>>> call(String uid) async {
    return await favouriteRepository.getFavouriteMatches(uid);
  }
}

class RemoveFavouriteMatchesUseCase implements UseCase<bool, RemoveFavouriteMatchesParam> {
  final FavouriteRepository favouriteRepository;

  RemoveFavouriteMatchesUseCase({required this.favouriteRepository});
  
  @override
  Future<Either<Failure, bool>> call(RemoveFavouriteMatchesParam item) async {
    return await favouriteRepository.removeFavouriteMatch(item.uid, item.fixtureId);
  }
}