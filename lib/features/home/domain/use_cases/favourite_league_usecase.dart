import 'package:dartz/dartz.dart';
import 'package:resultizer_merged/core/dto/response_dto.dart';
import 'package:resultizer_merged/core/error/error_handler.dart';
import 'package:resultizer_merged/core/usecase/usecase.dart';
import 'package:resultizer_merged/features/games/data/model/league_dto.dart';
import 'package:resultizer_merged/features/home/domain/repositories/favourite_repository.dart';

class SetFavouriteLeagueParam {
  final String uid;
   final Map<int, LeagueDTO> item;

  SetFavouriteLeagueParam({required this.uid, required this.item});
}

class RemoveFavouriteLeagueParam {
  final String uid;
   final int leagueId;

  RemoveFavouriteLeagueParam({required this.uid, required this.leagueId});
}

class SetFavouriteLeagueUseCase implements UseCase<bool, SetFavouriteLeagueParam> {
  final FavouriteRepository favouriteRepository;

  SetFavouriteLeagueUseCase({required this.favouriteRepository});
  
  @override
  Future<Either<Failure, bool>> call(SetFavouriteLeagueParam item) async {
    return await favouriteRepository.setFavouriteLeagues(item.uid, item.item);
  }
}

class GetFavouriteLeagueUseCase implements UseCase<ResponseDTO<Map<String, dynamic>>, String> {
  final FavouriteRepository favouriteRepository;

  GetFavouriteLeagueUseCase({required this.favouriteRepository});
  
  @override
  Future<Either<Failure, ResponseDTO<Map<String, dynamic>>>> call(String uid) async {
    return await favouriteRepository.getFavouriteLeagues(uid);
  }
}

class RemoveFavouriteLeagueUseCase implements UseCase<bool, RemoveFavouriteLeagueParam> {
  final FavouriteRepository favouriteRepository;

  RemoveFavouriteLeagueUseCase({required this.favouriteRepository});
  
  @override
  Future<Either<Failure, bool>> call(RemoveFavouriteLeagueParam item) async {
    return await favouriteRepository.removeFavouriteLeague(item.uid, item.leagueId);
  }
}