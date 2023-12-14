import 'package:dartz/dartz.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:resultizer_merged/core/error/error_handler.dart';
import 'package:resultizer_merged/core/usecase/usecase.dart';
import 'package:resultizer_merged/features/account/domain/repository/manage_chat_repository.dart';

class GetChatMetaUseCase implements UseCase<Iterable<DataSnapshot>, NoParams> {
  final ManageChatRepository _repository;
  GetChatMetaUseCase(this._repository);
  @override
  Future<Either<Failure, Iterable<DataSnapshot>>> call(NoParams params) async {
    return await _repository.getChatMeta();
  }
}

class CountChatUseCase implements UseCase<int, int> {
  final ManageChatRepository _repository;
  CountChatUseCase(this._repository);
  @override
  Future<Either<Failure, int>> call(int fixtureId) async {
    return await _repository.countChat(fixtureId: fixtureId);
  }
}

class DeleteChatUseCase implements UseCase<bool, int> {
  final ManageChatRepository _repository;
  DeleteChatUseCase(this._repository);
  @override
  Future<Either<Failure, bool>> call(int fixtureId) async {
    return await _repository.deleteChat(fixtureId: fixtureId);
  }
}

class DeleteChatMetaUseCase implements UseCase<bool, int> {
  final ManageChatRepository _repository;
  DeleteChatMetaUseCase(this._repository);
  @override
  Future<Either<Failure, bool>> call(int fixtureId) async {
    return await _repository.deleteChatMeta(fixtureId: fixtureId);
  }
}
