import 'package:dartz/dartz.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:resultizer_merged/core/error/error_handler.dart';
import 'package:resultizer_merged/core/network/network_info.dart';
import 'package:resultizer_merged/features/account/data/datasource/manage_chat_datasource.dart';
import 'package:resultizer_merged/features/account/data/datasource/user_detail_datasource.dart';
import 'package:resultizer_merged/features/account/domain/repository/manage_chat_repository.dart';
import 'package:resultizer_merged/features/auth/data/models/user_model.dart';

class ManageChatImplementation implements ManageChatRepository {
  final ManageChatDataSource dataSource;
  final NetworkInfo networkInfo;
  ManageChatImplementation({
    required this.dataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, int>> countChat(
      {required int fixtureId}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await dataSource.countChat(fixtureId);
        return Right(result);
      } catch (e, stackTrace) {
        print(e);
        print(stackTrace);
        return const Left(Failure(code: 01, message: 'unexpected'));
      }
    } else {
      return const Left(Failure(code: 02, message: 'networkConnectError'));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteChat({required int fixtureId}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await dataSource.deleteChat(fixtureId);
        return Right(result);
      } catch (e, stackTrace) {
        print(e);
        print(stackTrace);
        return const Left(Failure(code: 01, message: 'unexpected'));
      }
    } else {
      return const Left(Failure(code: 02, message: 'networkConnectError'));
    }
  }

  @override
  Future<Either<Failure, Iterable<DataSnapshot>>> getAllChatMeta() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await dataSource.getAllChatMeta();
        return Right(result);
      } catch (e, stackTrace) {
        print(e);
        print(stackTrace);
        return const Left(Failure(code: 01, message: 'unexpected'));
      }
    } else {
      return const Left(Failure(code: 02, message: 'networkConnectError'));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteChatMeta({required int fixtureId}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await dataSource.deleteChatMeta(fixtureId);
        return Right(result);
      } catch (e, stackTrace) {
        print(e);
        print(stackTrace);
        return const Left(Failure(code: 01, message: 'unexpected'));
      }
    } else {
      return const Left(Failure(code: 02, message: 'networkConnectError'));
    }
  }

  @override
  Future<Either<Failure, dynamic>> getChatMeta({required int fixtureId}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await dataSource.getChatMeta(fixtureId);
        return Right(result);
      } catch (e, stackTrace) {
        print(e);
        print(stackTrace);
        return const Left(Failure(code: 01, message: 'unexpected'));
      }
    } else {
      return const Left(Failure(code: 02, message: 'networkConnectError'));
    }
  }
}
