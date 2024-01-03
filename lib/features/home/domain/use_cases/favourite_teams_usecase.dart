import 'package:dartz/dartz.dart';
import 'package:resultizer_merged/core/dto/response_dto.dart';
import 'package:resultizer_merged/core/error/error_handler.dart';
import 'package:resultizer_merged/core/usecase/usecase.dart';
import 'package:resultizer_merged/features/games/data/model/team_list_item_dto.dart';
import 'package:resultizer_merged/features/home/domain/repositories/favourite_repository.dart';

class SetFavouriteTeamsParam {
  final String uid;
   final Map<int, TeamListItemDTO> item;

  SetFavouriteTeamsParam({required this.uid, required this.item});
}

class RemoveFavouriteTeamsParam {
  final String uid;
   final int teamId;

  RemoveFavouriteTeamsParam({required this.uid, required this.teamId});
}

class SetFavouriteTeamsUseCase implements UseCase<bool, SetFavouriteTeamsParam> {
  final FavouriteRepository favouriteRepository;

  SetFavouriteTeamsUseCase({required this.favouriteRepository});
  
  @override
  Future<Either<Failure, bool>> call(SetFavouriteTeamsParam item) async {
    return await favouriteRepository.setFavouriteTeam(item.uid, item.item);
  }
}


class GetFavouriteTeamsUseCase implements UseCase<ResponseDTO<Map<dynamic, dynamic>>, String> {
  final FavouriteRepository favouriteRepository;

  GetFavouriteTeamsUseCase({required this.favouriteRepository});
  
  @override
  Future<Either<Failure, ResponseDTO<Map<dynamic, dynamic>>>> call(String uid) async {
    return await favouriteRepository.getFavouriteTeams(uid);
  }
}

class RemoveFavouriteTeamsUseCase implements UseCase<bool, RemoveFavouriteTeamsParam> {
  final FavouriteRepository favouriteRepository;

  RemoveFavouriteTeamsUseCase({required this.favouriteRepository});
  
  @override
  Future<Either<Failure, bool>> call(RemoveFavouriteTeamsParam item) async {
    return await favouriteRepository.removeFavouriteTeam(item.uid, item.teamId);
  }
}