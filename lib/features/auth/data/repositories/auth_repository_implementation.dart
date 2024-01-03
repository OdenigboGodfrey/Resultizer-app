import 'package:dartz/dartz.dart';
import 'package:resultizer_merged/core/error/error_handler.dart';
import 'package:resultizer_merged/core/error/firebase_error_handler.dart';
import 'package:resultizer_merged/core/network/network_info.dart';
import 'package:resultizer_merged/features/auth/data/datasources/auth_datasource.dart';
import 'package:resultizer_merged/features/auth/domain/entities/user.dart';
import 'package:resultizer_merged/features/auth/domain/mappers/mappers.dart';
import 'package:resultizer_merged/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImplementation implements AuthRepository {
  final AuthDatasource datasource;
  final NetworkInfo networkInfo;
  AuthRepositoryImplementation({
    required this.datasource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, User>> logInWithEmail({required String email, required String password}) async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await datasource.logInWithEmail(email: email, password: password);
        final user = result.toDomain();
        return Right(user);
      } on AuthException catch (e) {
        return Left(Failure(code: 00, message: e.message));
      } catch (e) {
        // return Left(DataSource.unexpected.getFailure());
        return const Left(Failure(code: 01, message: 'unexpected'));
      }
    } else {
      // return Left(DataSource.networkConnectError.getFailure());
      return const Left(Failure(code: 02, message: 'networkConnectError'));
    }
  }

  @override
  Future<Either<Failure, User>> signInWithGoogle() {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> signUpWithEmail({required String email, required String password, required String name}) {
    // TODO: implement signUpWithEmail
    throw UnimplementedError();
  }
  
}