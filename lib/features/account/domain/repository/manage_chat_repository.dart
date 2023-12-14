import 'package:dartz/dartz.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:resultizer_merged/core/error/error_handler.dart';

abstract class ManageChatRepository {
  // Future<bool> readListen(Function emitter);
  Future<Either<Failure, int>> countChat({required int fixtureId});
  Future<Either<Failure, bool>> deleteChat({ required int fixtureId});
  Future<Either<Failure, Iterable<DataSnapshot>>> getChatMeta();
  Future<Either<Failure, bool>> deleteChatMeta({ required int fixtureId});
}